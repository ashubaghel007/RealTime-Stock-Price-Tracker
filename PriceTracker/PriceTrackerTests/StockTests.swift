//
//  StockTests.swift
//  PriceTracker
//
//  Created by Ashish Baghel on 14/10/2026.
//

import XCTest
@testable import PriceTracker

final class StockTests: XCTestCase {

    func test_newStock_hasNoChange() {
        let stock = Stock.fixture("AAA", price: 100)

        XCTAssertEqual(stock.change, 0)
        XCTAssertEqual(stock.changePercent, 0)
        XCTAssertEqual(stock.direction, .unchanged)
    }

    func test_updated_keepsPreviousPriceAndComputesChange() {
        let stock = Stock.fixture("AAA", price: 100).updated(to: 110)

        XCTAssertEqual(stock.price, 110)
        XCTAssertEqual(stock.previousPrice, 100)
        XCTAssertEqual(stock.change, 10, accuracy: 0.0001)
        XCTAssertEqual(stock.changePercent, 0.10, accuracy: 0.0001)
        XCTAssertEqual(stock.direction, .up)
    }

    func test_updated_toLowerPrice_isDown() {
        let stock = Stock.fixture("AAA", price: 100).updated(to: 95)

        XCTAssertEqual(stock.direction, .down)
        XCTAssertEqual(stock.changePercent, -0.05, accuracy: 0.0001)
    }

    func test_catalog_has25UniqueSymbols() {
        let symbols = Stock.catalog.map(\.symbol)

        XCTAssertEqual(symbols.count, 25)
        XCTAssertEqual(Set(symbols).count, 25)
    }

    func test_priceUpdate_roundTripsThroughJSON() throws {
        let updates = [PriceUpdate(symbol: "AAA", price: 12.34)]

        let data = try JSONEncoder().encode(updates)
        let decoded = try JSONDecoder().decode([PriceUpdate].self, from: data)

        XCTAssertEqual(decoded, updates)
    }
}
