//
//  MockWebSocketClient.swift
//  PriceTracker
//
//  Created by Ashish Baghel on 14/10/2026.
//

import Foundation
@testable import PriceTracker

/// Behaves like wss://ws.postman-echo.com/raw: every frame sent is queued and returned by the next `receive()`.
actor MockWebSocketClient: WebSocketClientAdapter {
    private(set) var connectCount = 0
    private(set) var disconnectCount = 0
    private(set) var sentMessages: [Data] = []
    private var pending: [Data] = []
    private var receiveError: Error?

    func connect() {
        connectCount += 1
    }

    func send(_ data: Data) throws {
        sentMessages.append(data)
        pending.append(data)
    }

    func receive() throws -> Data {
        if let receiveError { throw receiveError }
        guard !pending.isEmpty else { throw URLError(.badServerResponse) }
        return pending.removeFirst()
    }

    func disconnect() {
        disconnectCount += 1
    }

    // MARK: - Test controls

    func failReceive(with error: Error) {
        receiveError = error
    }
}
