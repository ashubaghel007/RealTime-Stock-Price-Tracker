//
//  SymbolDetailView.swift
//  PriceTracker
//
//  Created by Ashish Baghel on 14/10/2026.
//

import SwiftUI

struct SymbolDetailView: View {
    @State private var viewModel: SymbolDetailViewModel

    init(viewModel: SymbolDetailViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        Group {
            if let stock = viewModel.stock {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Text(stock.name)
                            .font(.title3)
                            .foregroundStyle(.secondary)

                        HStack(alignment: .firstTextBaseline, spacing: 12) {
                            Text(stock.price, format: .currency(code: "USD"))
                                .font(.system(size: 44, weight: .bold, design: .rounded).monospacedDigit())
                                .contentTransition(.numericText(value: stock.price))
                                .animation(.default, value: stock.price)
                            PriceChangeView(stock: stock)
                                .font(.title3.weight(.semibold))
                        }

                        Divider()

                        Text("About")
                            .font(.headline)
                        Text(stock.summary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                }
            } else {
                ContentUnavailableView("Symbol not found", systemImage: "questionmark.circle")
            }
        }
        .navigationTitle(viewModel.symbol)
    }
}
