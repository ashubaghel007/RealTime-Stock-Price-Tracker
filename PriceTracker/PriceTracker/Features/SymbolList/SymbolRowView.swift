//
//  SymbolRowView.swift
//  PriceTracker
//
//  Created by Ashish Baghel on 14/10/2026.
//

import SwiftUI

// MARK:  -  SymbolRowView -
struct SymbolRowView: View {
    let stock: Stock

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(stock.symbol)
                    .font(.headline)
                Text(stock.name)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 2) {
                Text(stock.price, format: .currency(code: "USD"))
                    .font(.body.monospacedDigit())
                    .contentTransition(.numericText(value: stock.price))
                    .animation(.default, value: stock.price)
                PriceChangeView(stock: stock)
                    .font(.caption.weight(.semibold))
            }
        }
        .padding(.vertical, 4)
        .accessibilityElement(children: .combine)
    }
}
