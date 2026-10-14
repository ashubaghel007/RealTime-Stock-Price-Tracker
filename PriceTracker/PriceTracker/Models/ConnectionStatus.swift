//
//  ConnectionStatus.swift
//  PriceTracker
//
//  Created by Ashish Baghel on 14/10/2026.
//

import Foundation

enum ConnectionStatus: Equatable, Sendable {
    case disconnected
    case connecting
    case connected
}
