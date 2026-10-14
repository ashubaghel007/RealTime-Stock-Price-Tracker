//
//  SymbolDetailViewModelTests.swift
//  PriceTracker
//
//  Created by Ashish Baghel on 14/10/2026.
//

import Observation
import XCTest
@testable import PriceTracker

final class SymbolDetailViewModelTests: XCTestCase {

    @MainActor
    private func makeSUT(symbol: String = "AAA") -> (sut: SymbolDetailViewModel, feed: SymbolListViewModel) {
        let feed = SymbolListViewModel(feedService: MockPriceFeedService(), stocks: [.fixture("AAA", price: 100)])
        return (SymbolDetailViewModel(symbol: symbol, feed: feed), feed)
    }

    @MainActor
    func test_stock_comesFromTheSharedFeed() {
        let (sut, _) = makeSUT()

        XCTAssertEqual(sut.symbol, "AAA")
        XCTAssertEqual(sut.stock?.price, 100)
    }

    @MainActor
    func test_unknownSymbol_hasNoStock() {
        let (sut, _) = makeSUT(symbol: "ZZZ")

        XCTAssertNil(sut.stock)
    }

    @MainActor
    func test_feedUpdate_isVisibleOnDetailScreen() {
        let (sut, feed) = makeSUT()

        feed.apply(PriceUpdate(symbol: "AAA", price: 105))

        XCTAssertEqual(sut.stock?.price, 105)
        XCTAssertEqual(sut.stock?.direction, .up)
    }

    /// Proves SwiftUI will re-render the detail screen: observers of `stock` get notified on a feed update.
    @MainActor
    func test_feedUpdate_notifiesDetailObservers() async {
        let (sut, feed) = makeSUT()
        let changed = expectation(description: "detail observers notified")
        withObservationTracking {
            _ = sut.stock
        } onChange: {
            changed.fulfill()
        }

        feed.apply(PriceUpdate(symbol: "AAA", price: 99))

        await fulfillment(of: [changed], timeout: 1)
    }
}
