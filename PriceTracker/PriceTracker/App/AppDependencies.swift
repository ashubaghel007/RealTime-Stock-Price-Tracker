//
//  AppDependencies.swift
//  PriceTracker
//
//  Created by Ashish Baghel on 14/10/2026.
//

import Foundation
// MARK:  -  App Dependencies -
/// Composition root: the only place that knows about concrete types.
struct AppDependencies {
    let priceFeedService: any PriceFeedServiceAdapter

    static var live: AppDependencies {
        let feed = EchoPriceFeedService(
            client: WebSocketNetworkClient(url: AppConstants.PriceFeed.url),
            initialPrices: Dictionary(uniqueKeysWithValues: Stock.catalog.map { ($0.symbol, $0.price) }),
            interval: AppConstants.PriceFeed.updateInterval
        )
        return AppDependencies(priceFeedService: feed)
    }
}
