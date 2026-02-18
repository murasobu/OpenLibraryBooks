//
//  SearchNavigationFactory.swift
//  OpenLibrary
//
//  Created by Suresh Gurung on 18/02/2026.
//

import SwiftUI

struct SearchNavigationFactory {
    let booksRepository: BooksRepository

    func destination(
        for genre: Genre
    ) -> some View {
        BooksListView(
            viewModel: BooksViewModel(
                repository: booksRepository,
                selectedGenre: genre
            )
        )
    }
}
