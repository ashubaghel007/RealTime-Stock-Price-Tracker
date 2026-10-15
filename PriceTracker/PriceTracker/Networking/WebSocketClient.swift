//
//  WebSocketClient.swift
//  PriceTracker
//
//  Created by Ashish Baghel on 14/10/2026.
//
import Foundation

// MARK: - URL Session WebSocket Client -
actor WebSocketNetworkClient: WebSocketClientAdapter {
    private let url: URL?
    private let session: URLSession
    private var webSocketTask: URLSessionWebSocketTask?

    init(url: URL? = AppConstants.PriceFeed.url,
         session: URLSession = .shared) {
        self.url = url
        self.session = session
    }

    func connect() async {
        guard webSocketTask == nil,
              let url = url else { return }
        let wsTask = session.webSocketTask(with: url)
        webSocketTask = wsTask
        wsTask.resume()
    }

    func send(_ data: Data) async throws {
        guard let webSocketTask else {
            throw URLError(.notConnectedToInternet)
        }
        try await webSocketTask.send(.string(String(decoding: data, as: UTF8.self)))
    }

    func receive() async throws -> Data {
        guard let webSocketTask else {
            throw URLError(.notConnectedToInternet)
        }
        switch try await webSocketTask.receive() {
        case .string(let text): return Data(text.utf8)
        case .data(let data): return data
        @unknown default: throw URLError(.cannotParseResponse)
        }
    }

    func disconnect() async {
        webSocketTask?.cancel(with: .goingAway, reason: nil)
        webSocketTask = nil
    }
}
