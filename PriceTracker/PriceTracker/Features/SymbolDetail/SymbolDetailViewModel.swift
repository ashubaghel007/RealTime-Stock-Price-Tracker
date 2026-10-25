//
//  SymbolDetailViewModel.swift
//  PriceTracker
//
//  Created by Ashish Baghel on 14/10/2026.
//

import Foundation
import Observation

// MARK:  -  SymbolDetailViewModel -
/// Reads from the shared feed, so the detail screen updates live with the list.
@MainActor
@Observable
final class SymbolDetailViewModel {
    let symbol: String
    private let feed: SymbolListViewModel

    init(symbol: String, feed: SymbolListViewModel) {
        self.symbol = symbol
        self.feed = feed
    }

    var stock: Stock? {
        feed.stock(for: symbol)
    }
}
