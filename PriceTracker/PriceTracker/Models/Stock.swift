//
//  Stock.swift
//  PriceTracker
//
//  Created by Ashish Baghel on 14/10/2026.
//

import Foundation

struct Stock: Identifiable, Hashable, Sendable {
    let symbol: String
    let name: String
    let summary: String
    private(set) var price: Double
    private(set) var previousPrice: Double

    var id: String { symbol }
    var change: Double { price - previousPrice }
    var changePercent: Double { previousPrice == 0 ? 0 : change / previousPrice }

    var direction: PriceDirection {
        if change > 0 { .up } else if change < 0 { .down } else { .unchanged }
    }

    init(symbol: String, name: String, summary: String, price: Double) {
        self.symbol = symbol
        self.name = name
        self.summary = summary
        self.price = price
        self.previousPrice = price
    }

    /// Returns a copy with the new price, keeping the current one as `previousPrice`.
    func updated(to newPrice: Double) -> Stock {
        var copy = self
        copy.previousPrice = price
        copy.price = newPrice
        return copy
    }
}

enum PriceDirection: Sendable {
    case up, down, unchanged
}
