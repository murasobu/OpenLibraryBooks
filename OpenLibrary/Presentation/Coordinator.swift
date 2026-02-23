//
//  Coordinator.swift
//  OpenLibrary
//
//  Created by Suresh Gurung on 21/02/2026.
//

import Combine
import SwiftUI

enum Screen: Hashable {
    case search
    case bookDetails(Book)
    case booksList(Genre)
    case favourites
}

@MainActor
class Coordinator: ObservableObject {

    @Published var searchPath: NavigationPath = NavigationPath()
    @Published var myBooksPath: NavigationPath = NavigationPath()

    private var booksRepository: BooksRepository = {
        let booksService = BooksServiceImpl()
        let localStorage = FileManagerStorage()
        return BooksRepositoryImpl(booksService: booksService, localStorage: localStorage)
    }()

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

    @ViewBuilder
    func build(screen: Screen) -> some View {
        switch screen {
        case .search:
            SearchView(viewModel: searchViewModel, navigationFactory: searchNavigationFactory)
        case .booksList(let genre):
            BooksListView(viewModel: BooksListViewModel(repository: booksRepository, selectedGenre: genre))
        case .bookDetails:
            EmptyView()
        case .favourites:
            EmptyView()
        }
    }

    func goTo(screen: Screen) {
        searchPath.append(screen)
    }

    func pop() {
        searchPath.removeLast()
    }

    func popToRoot() {
        searchPath.removeLast(searchPath.count)
    }

    func reset() {
        searchPath = NavigationPath()
    }
}
