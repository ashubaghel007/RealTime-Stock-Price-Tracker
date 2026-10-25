//
//  ConnectionStatusView.swift
//  PriceTracker
//
//  Created by Ashish Baghel on 14/10/2026.
//

import SwiftUI
// MARK:  -  ConnectionStatusView -
struct ConnectionStatusView: View {
    let status: ConnectionStatus

    var body: some View {
        Image(systemName: status.symbolName)
            .font(.system(size: 16))
            .foregroundStyle(status.color)
            .accessibilityLabel(Text(status.title))
    }
}
