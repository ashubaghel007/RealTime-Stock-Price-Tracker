//
//  AppDependencies.swift
//  PriceTracker
//
//  Created by Ashish Baghel on 14/10/2026.
//

import Foundation

/// Per-environment settings. A regional build (EU, APAC, …) only needs a different instance of this.
struct AppConfiguration: Sendable {
    let priceFeedURL: URL?
    let updateInterval: Duration

    static let current = AppConfiguration(
        priceFeedURL: URL(string: "wss://ws.postman-echo.com/raw"),
        updateInterval: .seconds(2)
    )
}

/// Composition root: the only place that knows about concrete types.
struct AppDependencies {
    let priceFeedService: any PriceFeedService

    static var live: AppDependencies {
        let configuration = AppConfiguration.current
        let feed = EchoPriceFeed(
            client: WebSocketNetworkClient(url: configuration.priceFeedURL),
            initialPrices: Dictionary(uniqueKeysWithValues: Stock.catalog.map { ($0.symbol, $0.price) }),
            interval: configuration.updateInterval
        )
        return AppDependencies(priceFeedService: feed)
    }
}
