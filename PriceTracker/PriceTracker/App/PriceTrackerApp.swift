//
//  PriceTrackerApp.swift
//  PriceTracker
//
//  Created by Ashish Baghel on 14/10/2026.
//

import SwiftUI

@main
struct PriceTrackerApp: App {
    @State private var viewModel = SymbolListViewModel(
        feedService: AppDependencies.live.priceFeedService
    )

    var body: some Scene {
        WindowGroup {
            SymbolListView(viewModel: viewModel)
        }
    }
}
