//
//  ContentView.swift
//  OpenLibrary
//
//  Created by Santa Gurung on 19/12/2025.
//

import SwiftUI

struct ContentView: View {

	@State private var path = NavigationPath()

	@StateObject private var booksViewModel: BooksViewModel = {
		let booksService = BooksServiceImpl()
		let localStorage = FileManagerStorage()
		let booksRepository = BooksRepositoryImpl(booksService: booksService, localStorage: localStorage)
		return BooksViewModel(repository: booksRepository)
	}()

	var body: some View {
        TabView {
            SearchView()
                .tabItem {
                    Label(.searchTab, systemImage: "magnifyingglass")
                }
            
            NavigationStack(path: $path) {
                BooksView(viewModel: booksViewModel)
            }
            .tabItem {
                Label(.myBooksTab, systemImage: "book")
            }
        }
	}
}

#Preview {
	ContentView()
}
