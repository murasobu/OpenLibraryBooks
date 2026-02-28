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

    private var genreRepository: GenreRepository = {
        let genreService = GenreServiceImpl()
        let localStorage = FileManagerStorage()
        return GenreRepositoryImpl(genreService: genreService, localStorage: localStorage)
    }()

    private var searchViewModel: SearchViewModel = {
        let searchService = SearchServiceImpl()
        let searchRepository = SearchRepositoryImpl(searchService: searchService)
        return SearchViewModel(searchRepository: searchRepository)
    }()

    private var booksListViewModels: [Genre: BooksListViewModel] = [:]

    @ViewBuilder
    func build(screen: Screen) -> some View {
        switch screen {
        case .search:
            SearchView(viewModel: searchViewModel)

        case .booksList(let genre):
            let viewModel = booksListViewModels[genre] ?? {
                let viewModel = BooksListViewModel(repository: genreRepository, selectedGenre: genre)
                booksListViewModels[genre] = viewModel
                return viewModel
            }()
            BooksListView(viewModel: viewModel)

        case .bookDetails(let book):
            BookDetailView(book: book)

        case .favourites:
            EmptyView()
        }
    }

    // Optionally, provide a method to clear/reset cache if needed:
    func clearBooksListCache() {
        booksListViewModels.removeAll()
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
