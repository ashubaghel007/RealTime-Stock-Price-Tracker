//
//  MBPTWebSocketNetworkClient.swift
//  PriceTracker
//
//  Created by Ashish Baghel on 14/10/2026.
//
import Foundation

// MARK: - WebSocket Client -
actor MBPTWebSocketNetworkClient: MBPTWebSocketNetworkClientAdapter {
    private let url: URL?
    private let session: URLSession
    private var task: URLSessionWebSocketTask?

    init(url: URL? = URL(string: "wss://ws.postman-echo.com/raw"),
         session: URLSession = .shared) {
        self.url = url
        self.session = session
    }

    func connect() async {
        guard task == nil,
              let url = url else { return }
        let socket = session.webSocketTask(with: url)
        task = socket
        socket.resume()
    }

    func send(_ data: Data) async throws {
        guard let task else { throw URLError(.notConnectedToInternet) }
        try await task.send(.string(String(decoding: data, as: UTF8.self)))
    }

    func receive() async throws -> Data {
        guard let task else { throw URLError(.notConnectedToInternet) }
        switch try await task.receive() {
        case .string(let text): return Data(text.utf8)
        case .data(let data): return data
        @unknown default: throw URLError(.cannotParseResponse)
        }
    }

    func disconnect() async {
        task?.cancel(with: .goingAway, reason: nil)
        task = nil
    }
}
