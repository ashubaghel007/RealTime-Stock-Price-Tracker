//
//  MockPriceFeedService.swift
//  PriceTracker
//
//  Created by Ashish Baghel on 14/10/2026.
//

import Foundation
@testable import PriceTracker

/// Lets a test push price updates by hand through `continuation`.
final class MockPriceFeedService: PriceFeedService {
    let stream: AsyncThrowingStream<PriceUpdate, Error>
    let continuation: AsyncThrowingStream<PriceUpdate, Error>.Continuation

    init() {
        let (stream, continuation) = AsyncThrowingStream.makeStream(of: PriceUpdate.self)
        self.stream = stream
        self.continuation = continuation
    }

    func prices() -> AsyncThrowingStream<PriceUpdate, Error> {
        stream
    }
}
