//
//  ContentView.swift
//  OpenLibrary
//
//  Created by Suresh Gurung on 21/02/2026.
//

import SwiftUI

struct ContentView: View {

    @StateObject var coordinator = Coordinator()

    var body: some View {
        TabView {
            NavigationStack(path: $coordinator.searchPath) {
                coordinator.build(screen: .search)
                    .navigationDestination(for: Screen.self) { screen in
                        coordinator.build(screen: screen)
                    }
            }
            .tabItem {
                Label(.searchTab, systemImage: "magnifyingglass")
            }

            NavigationStack(path: $coordinator.myBooksPath) {
                coordinator.build(screen: .favourites)
                    .navigationDestination(for: Screen.self) { screen in
                        coordinator.build(screen: screen)
                    }
            }
            .tabItem {
                Label(.myBooksTab, systemImage: "book")
            }
        }
        .environmentObject(coordinator)
    }
}
