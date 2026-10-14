//
//  WebSocketClientAdapter.swift
//  PriceTracker
//
//  Created by Ashish Baghel on 15/10/2026.
//

import Foundation

// MARK: - WebSocketClient Protocol -
protocol WebSocketClientAdapter: Sendable {
    func connect() async
    func send(_ data: Data) async throws
    func receive() async throws -> Data
    func disconnect() async
}
