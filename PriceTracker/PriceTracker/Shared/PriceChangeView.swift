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
            Image(systemName: iconName)
            Text(abs(stock.changePercent), format: .percent.precision(.fractionLength(2)))
                .monospacedDigit()
        }
        .foregroundStyle(color)
    }

    private var iconName: String {
        switch stock.direction {
        case .up: "arrowtriangle.up.fill"
        case .down: "arrowtriangle.down.fill"
        case .unchanged: "minus"
        }
    }

    private var color: Color {
        switch stock.direction {
        case .up: .green
        case .down: .red
        case .unchanged: .secondary
        }
    }
}
