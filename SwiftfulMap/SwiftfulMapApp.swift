//
//  SwiftfulMapApp.swift
//  SwiftfulMap
//
//  Created by wizz on 2/13/22.
//

import SwiftUI

@main
struct SwiftfulMapApp: App {
    @StateObject private var viewModel = LocationsViewModel()
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(viewModel)
        }
    }
}
