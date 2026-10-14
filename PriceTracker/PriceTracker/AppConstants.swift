//
//  AppConstants.swift
//  PriceTracker
//
//  Created by Ashish Baghel on 14/10/2026.
//

import Foundation

// MARK: - App Constants -

/// Single place for app-wide settings. Change values here, nowhere else.
enum AppConstants {

    enum PriceFeed {
        /// WebSocket echo server that returns every message we send.
        static let url = URL(string: "wss://ws.postman-echo.com/raw")!

        /// How often a new batch of prices is generated and sent.
        static let updateInterval: Duration = .seconds(2)

        /// Largest random move per tick, as a fraction of the price (0.02 = ±2%).
        static let maxPriceChange = 0.02
    }

    enum Formatting {
        /// Currency the prices are quoted in.
        static let currencyCode = "USD"
    }
}
