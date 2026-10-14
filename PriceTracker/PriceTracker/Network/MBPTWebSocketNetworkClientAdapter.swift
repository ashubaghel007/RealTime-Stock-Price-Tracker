//
//  MBPTWebSocketNetworkClientAdapter.swift
//  PriceTracker
//
//  Created by Ashish Baghel on 14/10/2026.
//

import Foundation

// MARK: - WebSocket Client Protocol
protocol MBPTWebSocketNetworkClientAdapter: Sendable {
    func connect() async
    func send(_ data: Data) async throws
    func receive() async throws -> Data
    func disconnect() async
}
