//
//  ContentView.swift
//  OpenLibrary
//
//  Created by Santa Gurung on 19/12/2025.
//

import SwiftUI

struct ContentView: View {

    private var searchNavigationFactory: SearchNavigationFactory = {
        let booksService = BooksServiceImpl()
        let localStorage = FileManagerStorage()
        let booksRepository = BooksRepositoryImpl(booksService: booksService, localStorage: localStorage)
        return SearchNavigationFactory(booksRepository: booksRepository)
    }()
    
    private var searchViewModel: SearchViewModel = {
        let searchService = SearchServiceImpl()
        let searchRepository = SearchRepositoryImpl(searchService: searchService)
        return SearchViewModel(searchRepository: searchRepository)
    }()
    
	var body: some View {
        TabView {
            SearchView(viewModel: searchViewModel, navigationFactory: searchNavigationFactory)
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
