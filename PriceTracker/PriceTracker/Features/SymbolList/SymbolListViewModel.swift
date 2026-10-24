//
//  SymbolListViewModel.swift
//  PriceTracker
//
//  Created by Ashish Baghel on 14/10/2026.
//

import Foundation
import Observation

/// Owns the price feed and is the single source of truth for prices on every screen.
@MainActor
@Observable
final class SymbolListViewModel {
    enum SortOption: CaseIterable, Identifiable {
        case price
        case priceChange

        var id: Self { self }

        var title: LocalizedStringResource {
            switch self {
            case .price: "Price"
            case .priceChange: "Price Change"
            }
        }
    }

    private(set) var stocksBySymbol: [String: Stock]
    private(set) var connectionStatus: ConnectionStatus = .disconnected
    private(set) var errorMessage: String?
    var sortOption: SortOption = .price

    @ObservationIgnored private var feedTask: Task<Void, Never>?
    private let feedService: any PriceFeedServiceAdapter

    init(feedService: any PriceFeedServiceAdapter, stocks: [Stock] = Stock.catalog) {
        self.feedService = feedService
        self.stocksBySymbol = Dictionary(uniqueKeysWithValues: stocks.map { ($0.symbol, $0) })
    }

    var stocks: [Stock] {
        stocksBySymbol.values.sorted { lhs, rhs in
            let (left, right) = switch sortOption {
            case .price: (lhs.price, rhs.price)
            case .priceChange: (lhs.changePercent, rhs.changePercent)
            }
            // Ties fall back to the symbol so rows don't jump around randomly.
            return left != right ? left > right : lhs.symbol < rhs.symbol
        }
    }

    var isFeedRunning: Bool { connectionStatus != .disconnected }

    func stock(for symbol: String) -> Stock? {
        stocksBySymbol[symbol]
    }

    // MARK: - Feed control

    func toggleFeed() {
        isFeedRunning ? stopFeed() : startFeed()
    }

    func startFeed() {
        guard feedTask == nil else { return }
        errorMessage = nil
        connectionStatus = .connecting

        let updates = feedService.prices()
        feedTask = Task { [weak self] in
            do {
                for try await update in updates {
                    self?.didReceive(update)
                }
                self?.feedDidEnd(with: nil)
            } catch {
                self?.feedDidEnd(with: error)
            }
        }
    }

    func stopFeed() {
        feedTask?.cancel()
        feedTask = nil
        connectionStatus = .disconnected
    }

    // MARK: - Updates

    func apply(_ update: PriceUpdate) {
        stocksBySymbol[update.symbol] = stocksBySymbol[update.symbol]?.updated(to: update.price)
    }

    /// The first echoed price is our proof the socket is open.
    private func didReceive(_ update: PriceUpdate) {
        if connectionStatus != .connected {
            connectionStatus = .connected
        }
        apply(update)
    }

    private func feedDidEnd(with error: Error?) {
        guard !Task.isCancelled else { return }
        feedTask = nil
        connectionStatus = .disconnected
        if error != nil {
            errorMessage = String(localized: "Connection lost. Tap Start to reconnect.")
        }
    }
}
