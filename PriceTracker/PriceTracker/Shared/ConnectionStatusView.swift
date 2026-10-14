//
//  ConnectionStatusView.swift
//  PriceTracker
//
//  Created by Ashish Baghel on 14/10/2026.
//

import SwiftUI

struct ConnectionStatusView: View {
    let status: ConnectionStatus

    var body: some View {
        HStack(spacing: 6) {
            Circle()
                .fill(color)
                .frame(width: 8, height: 8)
            Text(title)
                .font(.caption.weight(.medium))
        }
        .accessibilityElement(children: .combine)
    }

    private var title: LocalizedStringKey {
        switch status {
        case .connected: "Connected"
        case .connecting: "Connecting…"
        case .disconnected: "Disconnected"
        }
    }

    private var color: Color {
        switch status {
        case .connected: .green
        case .connecting: .orange
        case .disconnected: .red
        }
    }
}
