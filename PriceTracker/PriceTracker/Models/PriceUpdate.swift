//
//  PriceUpdate.swift
//  PriceTracker
//
//  Created by Ashish Baghel on 14/10/2026.
//

import Foundation

// MARK:  -  PriceUpdate -
/// Wire format sent to (and echoed back by) the WebSocket server.
struct PriceUpdate: Codable, Equatable, Sendable {
    let symbol: String
    let price: Double
}
