//
//  SymbolListViewModelTests.swift
//  PriceTracker
//
//  Created by Ashish Baghel on 14/10/2026.
//

import XCTest
@testable import PriceTracker

final class SymbolListViewModelTests: XCTestCase {

    @MainActor
    private func makeSUT(
        stocks: [Stock] = [.fixture("AAA", price: 100), .fixture("BBB", price: 50), .fixture("CCC", price: 200)]
    ) -> (sut: SymbolListViewModel, service: MockPriceFeedService) {
        let service = MockPriceFeedService()
        let sut = SymbolListViewModel(feedService: service, stocks: stocks)
        return (sut, service)
    }

    // MARK: - Initial state

    @MainActor
    func test_init_isDisconnectedAndShowsAllSymbols() {
        let (sut, _) = makeSUT()

        XCTAssertEqual(sut.connectionStatus, .disconnected)
        XCTAssertFalse(sut.isFeedRunning)
        XCTAssertEqual(sut.stocks.count, 3)
    }

    // MARK: - Feed lifecycle

    @MainActor
    func test_startFeed_isConnectingUntilFirstPriceArrives() async {
        let (sut, service) = makeSUT()

        sut.startFeed()
        XCTAssertEqual(sut.connectionStatus, .connecting)

        service.continuation.yield(PriceUpdate(symbol: "AAA", price: 120))

        await waitUntil { sut.connectionStatus == .connected }
        XCTAssertEqual(sut.stock(for: "AAA")?.price, 120)
    }

    @MainActor
    func test_stopFeed_disconnectsAndTerminatesStream() async {
        let (sut, service) = makeSUT()
        let terminated = expectation(description: "stream terminated")
        service.continuation.onTermination = { _ in terminated.fulfill() }
        sut.startFeed()

        sut.stopFeed()

        XCTAssertEqual(sut.connectionStatus, .disconnected)
        await fulfillment(of: [terminated], timeout: 1)
    }

    @MainActor
    func test_toggleFeed_startsThenStops() {
        let (sut, _) = makeSUT()

        sut.toggleFeed()
        XCTAssertTrue(sut.isFeedRunning)

        sut.toggleFeed()
        XCTAssertFalse(sut.isFeedRunning)
    }

    @MainActor
    func test_feedError_disconnectsAndShowsMessage() async {
        let (sut, service) = makeSUT()
        sut.startFeed()

        service.continuation.finish(throwing: URLError(.networkConnectionLost))

        await waitUntil { sut.connectionStatus == .disconnected }
        XCTAssertNotNil(sut.errorMessage)
    }

    // MARK: - Updates

    @MainActor
    func test_apply_updatesPriceAndKeepsPrevious() {
        let (sut, _) = makeSUT()

        sut.apply(PriceUpdate(symbol: "AAA", price: 110))

        XCTAssertEqual(sut.stock(for: "AAA")?.price, 110)
        XCTAssertEqual(sut.stock(for: "AAA")?.previousPrice, 100)
        XCTAssertEqual(sut.stock(for: "AAA")?.direction, .up)
    }

    @MainActor
    func test_apply_ignoresUnknownSymbols() {
        let (sut, _) = makeSUT()

        sut.apply(PriceUpdate(symbol: "ZZZ", price: 1))

        XCTAssertNil(sut.stock(for: "ZZZ"))
        XCTAssertEqual(sut.stocks.count, 3)
    }

    // MARK: - Sorting

    @MainActor
    func test_sortByPrice_isDescending() {
        let (sut, _) = makeSUT()

        sut.sortOption = .price

        XCTAssertEqual(sut.stocks.map(\.symbol), ["CCC", "AAA", "BBB"])
    }

    @MainActor
    func test_sortByPriceChange_isDescendingByPercent() {
        let (sut, _) = makeSUT()
        sut.apply(PriceUpdate(symbol: "AAA", price: 90))  // -10%
        sut.apply(PriceUpdate(symbol: "BBB", price: 55))  // +10%
        sut.apply(PriceUpdate(symbol: "CCC", price: 202)) // +1%

        sut.sortOption = .priceChange

        XCTAssertEqual(sut.stocks.map(\.symbol), ["BBB", "CCC", "AAA"])
    }

    @MainActor
    func test_sort_tiesFallBackToSymbol() {
        let (sut, _) = makeSUT(stocks: [.fixture("BBB", price: 10), .fixture("AAA", price: 10)])

        sut.sortOption = .priceChange

        XCTAssertEqual(sut.stocks.map(\.symbol), ["AAA", "BBB"])
    }
}
