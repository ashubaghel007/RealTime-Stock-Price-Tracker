//
//  TestHelpers.swift
//  PriceTracker
//
//  Created by Ashish Baghel on 14/10/2026.
//

import XCTest
@testable import PriceTracker

extension Stock {
    static func fixture(_ symbol: String, price: Double) -> Stock {
        Stock(symbol: symbol, name: "\(symbol) Inc.", summary: "About \(symbol).", price: price)
    }
}

/// Polls `condition` until it's true or the timeout expires.
/// Keeps async tests deterministic without fixed sleeps.
@MainActor
func waitUntil(
    timeout: Duration = .seconds(2),
    file: StaticString = #filePath,
    line: UInt = #line,
    _ condition: () -> Bool
) async {
    let clock = ContinuousClock()
    let deadline = clock.now.advanced(by: timeout)
    while !condition() {
        guard clock.now < deadline else {
            XCTFail("Condition not met within \(timeout)", file: file, line: line)
            return
        }
        try? await Task.sleep(for: .milliseconds(10))
    }
}
