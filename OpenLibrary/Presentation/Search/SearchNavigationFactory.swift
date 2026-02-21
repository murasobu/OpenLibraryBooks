//
//  SearchNavigationFactory.swift
//  OpenLibrary
//
//  Created by Suresh Gurung on 18/02/2026.
//

import SwiftUI

struct SearchNavigationFactory {
    let booksRepository: BooksRepository

    func destination(genre: Genre) -> some View {
        BooksListView(
            viewModel: BooksListViewModel(
                repository: booksRepository,
                selectedGenre: genre
            )
        )
    }

    func destination(book: Book) -> some View {
        BookDetailView(
            book: book
        )
    }
}
