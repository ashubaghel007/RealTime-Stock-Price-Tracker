//
//  EchoPriceFeedTests.swift
//  PriceTracker
//
//  Created by Ashish Baghel on 14/10/2026.
//

import XCTest
@testable import PriceTracker

final class EchoPriceFeedTests: XCTestCase {

    private let initialPrices = ["AAA": 100.0, "BBB": 50.0]

    private func makeSUT(client: MockWebSocketClient) -> EchoPriceFeed {
        EchoPriceFeed(client: client, initialPrices: initialPrices, interval: .milliseconds(10))
    }

    /// Reads exactly `count` updates from the stream.
    private func firstUpdates(_ count: Int, from stream: AsyncThrowingStream<PriceUpdate, Error>) async throws -> [PriceUpdate] {
        var iterator = stream.makeAsyncIterator()
        var updates: [PriceUpdate] = []
        while updates.count < count, let update = try await iterator.next() {
            updates.append(update)
        }
        return updates
    }

    func test_prices_connectsOnce() async throws {
        let client = MockWebSocketClient()

        _ = try await firstUpdates(2, from: makeSUT(client: client).prices())

        let connectCount = await client.connectCount
        XCTAssertEqual(connectCount, 1)
    }

    func test_prices_yieldsOneUpdatePerSymbolEachTick() async throws {
        let client = MockWebSocketClient()

        let updates = try await firstUpdates(2, from: makeSUT(client: client).prices())

        XCTAssertEqual(Set(updates.map(\.symbol)), ["AAA", "BBB"])
    }

    func test_prices_yieldsExactlyWhatWasEchoed() async throws {
        let client = MockWebSocketClient()

        let updates = try await firstUpdates(2, from: makeSUT(client: client).prices())

        let sent = await client.sentMessages
        let firstBatch = try JSONDecoder().decode([PriceUpdate].self, from: XCTUnwrap(sent.first))
        XCTAssertEqual(updates, firstBatch)
    }

    func test_prices_moveWithinTwoPercentOfTheStartingPrice() async throws {
        let client = MockWebSocketClient()

        let updates = try await firstUpdates(2, from: makeSUT(client: client).prices())

        for update in updates {
            let start = try XCTUnwrap(initialPrices[update.symbol])
            XCTAssertEqual(update.price, start, accuracy: start * PriceGenerator.maxChange + 0.01)
        }
    }

    func test_receiveError_finishesStreamWithError() async {
        let client = MockWebSocketClient()
        await client.failReceive(with: URLError(.networkConnectionLost))

        do {
            _ = try await firstUpdates(1, from: makeSUT(client: client).prices())
            XCTFail("Expected an error")
        } catch {
            XCTAssertEqual(error as? URLError, URLError(.networkConnectionLost))
        }
    }

    func test_cancellingConsumer_disconnectsClient() async throws {
        let client = MockWebSocketClient()
        let stream = makeSUT(client: client).prices()
        let consumer = Task {
            for try await _ in stream {}
        }
        try await Task.sleep(for: .milliseconds(50))

        consumer.cancel()

        var disconnectCount = 0
        for _ in 0..<100 where disconnectCount == 0 {
            try await Task.sleep(for: .milliseconds(10))
            disconnectCount = await client.disconnectCount
        }
        XCTAssertEqual(disconnectCount, 1)
    }
}

final class PriceGeneratorTests: XCTestCase {

    func test_nextPrice_staysWithinTwoPercent() {
        for _ in 0..<1_000 {
            let next = PriceGenerator.nextPrice(from: 100)
            XCTAssertGreaterThanOrEqual(next, 98)
            XCTAssertLessThanOrEqual(next, 102)
        }
    }

    func test_nextPrice_isRoundedToCents() {
        for _ in 0..<100 {
            let next = PriceGenerator.nextPrice(from: 123.45)
            XCTAssertEqual(next, (next * 100).rounded() / 100)
        }
    }

    func test_nextPrice_neverDropsBelowOneCent() {
        XCTAssertGreaterThanOrEqual(PriceGenerator.nextPrice(from: 0.01), 0.01)
    }
}
