//
//  PriceGenerator.swift
//  PriceTracker
//
//  Created by Ashish Baghel on 14/10/2026.
//

import Foundation

// MARK: - Price Generator -
enum PriceGenerator {
    static let maxChange = 0.02

    /// Moves the price randomly by up to ±2%, rounded to cents and never below one cent.
    static func nextPrice(from price: Double) -> Double {
        let next = price * (1 + Double.random(in: -maxChange...maxChange))
        return max((next * 100).rounded() / 100, 0.01)
    }
}
