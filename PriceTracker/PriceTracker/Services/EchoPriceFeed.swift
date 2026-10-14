//
//  EchoPriceFeed.swift
//  PriceTracker
//
//  Created by Ashish Baghel on 14/10/2026.
//

import Foundation

// MARK: - Echo Price Feed -
struct EchoPriceFeed: PriceFeedService {
    let client: any WebSocketClientAdapter
    let initialPrices: [String: Double]
    var interval: Duration = .seconds(2)

    func prices() -> AsyncThrowingStream<PriceUpdate, Error> {
        AsyncThrowingStream { continuation in
            let task = Task {
                do {
                    await client.connect()
                    var currentPrices = initialPrices

                    while !Task.isCancelled {
                        let updates = currentPrices.map { symbol, price in
                            PriceUpdate(symbol: symbol, price: PriceGenerator.nextPrice(from: price))
                        }
                        try await client.send(JSONEncoder().encode(updates))
                        let echoed = try JSONDecoder().decode(
                            [PriceUpdate].self,
                            from: await client.receive()
                        )

                        for update in echoed {
                            currentPrices[update.symbol] = update.price
                            continuation.yield(update)
                        }
                        try await Task.sleep(for: interval)
                    }
                    continuation.finish()
                } catch is CancellationError {
                    continuation.finish()
                } catch {
                    continuation.finish(throwing: error)
                }

                // Disconnect inside the feed's own task, after the loop has stopped,
                // so it can't race with a send/receive that's still in flight.
                await client.disconnect()
            }

            continuation.onTermination = { _ in task.cancel() }
        }
    }
}
