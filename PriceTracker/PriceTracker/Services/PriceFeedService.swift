//
//  PriceFeedService.swift
//  PriceTracker
//
//  Created by Ashish Baghel on 14/10/2026.
//

import Foundation

// MARK:  -  Price Feed Service  -

/// The stream's lifetime is the feed's lifetime: cancel the consumer and the feed shuts down.
protocol PriceFeedServiceAdapter: Sendable {
    func prices() -> AsyncThrowingStream<PriceUpdate, Error>
}
