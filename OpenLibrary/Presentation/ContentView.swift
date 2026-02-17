//
//  ContentView.swift
//  OpenLibrary
//
//  Created by Santa Gurung on 19/12/2025.
//

import SwiftUI

struct ContentView: View {

	private var booksRepository: BooksRepository = {
		let booksService = BooksServiceImpl()
		let localStorage = FileManagerStorage()
		return BooksRepositoryImpl(booksService: booksService, localStorage: localStorage)
	}()

	var body: some View {
        TabView {
            SearchView(booksRepository: booksRepository)
                .tabItem {
                    Label(.searchTab, systemImage: "magnifyingglass")
                }
            
            MyBooksView()
                .tabItem {
                    Label(.myBooksTab, systemImage: "book")
                }
        }
	}
}

#Preview {
	ContentView()
}
