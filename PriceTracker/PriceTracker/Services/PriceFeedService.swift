//
//  PriceFeedService.swift
//  PriceTracker
//
//  Created by Ashish Baghel on 14/10/2026.
//

import Foundation

// MARK:  -  Price Feed Service  -

protocol PriceFeedServiceAdapter: Sendable {
    func prices() -> AsyncThrowingStream<PriceUpdate, Error>
}
