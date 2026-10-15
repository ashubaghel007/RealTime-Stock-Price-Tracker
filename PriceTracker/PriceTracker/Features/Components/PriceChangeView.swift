//
//  PriceChangeView.swift
//  PriceTracker
//
//  Created by Ashish Baghel on 14/10/2026.
//

import SwiftUI

/// Arrow + percentage change, shared by the list row and the detail screen.
struct PriceChangeView: View {
    let stock: Stock

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: stock.direction.iconName)
            Text(abs(stock.changePercent), format: .percent.precision(.fractionLength(2)))
                .monospacedDigit()
        }
        .foregroundStyle(stock.direction.color)
    }
}
