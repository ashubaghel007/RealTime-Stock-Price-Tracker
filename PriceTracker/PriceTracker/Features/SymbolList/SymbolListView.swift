//
//  SymbolListView.swift
//  PriceTracker
//
//  Created by Ashish Baghel on 14/10/2026.
//

import SwiftUI

struct SymbolListView: View {
    @State private var viewModel: SymbolListViewModel

    init(viewModel: SymbolListViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            List(viewModel.stocks) { stock in
                NavigationLink(value: stock.symbol) {
                    SymbolRowView(stock: stock)
                }
            }
            .listStyle(.plain)
            .animation(.default, value: viewModel.stocks.map(\.id))
            .safeAreaInset(edge: .top) { header }
            .navigationTitle("Stocks")
            .navigationDestination(for: String.self) { symbol in
                SymbolDetailView(viewModel: SymbolDetailViewModel(symbol: symbol, feed: viewModel))
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    ConnectionStatusView(status: viewModel.connectionStatus)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(feedButtonTitle) {
                        viewModel.toggleFeed()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(viewModel.isFeedRunning ? .red : .green)
                }
            }
        }
    }

    /// Typed as `LocalizedStringKey` so both titles are looked up in the String Catalog.
    private var feedButtonTitle: LocalizedStringKey {
        viewModel.isFeedRunning ? "Stop" : "Start"
    }

    private var header: some View {
        VStack(spacing: 8) {
            Picker("Sort by", selection: $viewModel.sortOption) {
                ForEach(SymbolListViewModel.SortOption.allCases) { option in
                    Text(option.title).tag(option)
                }
            }
            .pickerStyle(.segmented)

            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .font(.footnote)
                    .foregroundStyle(.red)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(.bar)
    }
}

#Preview("English") {
    SymbolListView(viewModel: SymbolListViewModel(feedService: AppDependencies.live.priceFeedService))
}

#Preview("Arabic") {
    SymbolListView(viewModel: SymbolListViewModel(feedService: AppDependencies.live.priceFeedService))
        .environment(\.locale, Locale(identifier: "ar"))
        .environment(\.layoutDirection, .rightToLeft)
}
