//
//  ConnectionStatus.swift
//  PriceTracker
//
//  Created by Ashish Baghel on 14/10/2026.
//

import Foundation
import SwiftUI

// MARK:  -  ConnectionStatus -
enum ConnectionStatus: Equatable, Sendable {
    case disconnected
    case connecting
    case connected
}

extension ConnectionStatus {
    var title: LocalizedStringKey {
        switch self {
        case .connected: "Connected"
        case .connecting: "Connecting…"
        case .disconnected: "Disconnected"
        }
    }

     var color: Color {
        switch self {
        case .connected: .green
        case .connecting: .orange
        case .disconnected: .red
        }
    }

    var symbolName: String {
        switch self {
        case .connected, .disconnected: "circle.fill"
        case .connecting: "circle.dotted"
        }
    }
}
