//
//  PriceFeedService.swift
//  PriceTracker
//
//  Created by Ashish Baghel on 14/10/2026.
//

import Foundation

// MARK:  -  Price Feed Service  -

/// What the app needs from a price source. The ViewModel depends on this, never on a concrete feed.
/// The stream's lifetime is the feed's lifetime: cancel the consumer and the feed shuts down.
protocol PriceFeedService: Sendable {
    func prices() -> AsyncThrowingStream<PriceUpdate, Error>
}
