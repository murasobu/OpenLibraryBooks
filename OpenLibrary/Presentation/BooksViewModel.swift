//
//  BooksViewModel.swift
//  OpenLibrary
//
//  Created by Santa Gurung on 19/12/2025.
//

import SwiftUI
import Combine

enum BooksViewState: Equatable {
	case loading
	case loaded([Book])
	case error(String)
}

@MainActor
final class BooksViewModel: ObservableObject {

	@Published private(set) var state: BooksViewState = .loading
	@Published var selectedGenre: Genre = .scienceFiction
	private let repository: BooksRepository

	init(repository: BooksRepository) {
		self.repository = repository
	}

	func getBooks() async {
		state = .loading
		do {
			let books = try await repository.fetchBooks(genre: selectedGenre)
			state = .loaded(books)
		} catch {
			state = .error(error.localizedDescription)
		}

	}
}

// MARK: - ViewModels for Previews

extension BooksViewModel {

	static var previewForLoadingState: BooksViewModel {
		let viewModel = BooksViewModel(repository: PreviewBooksRepositoryImpl())
		viewModel.state = .loading

		return viewModel
	}

	static var previewForLoadedState: BooksViewModel {
		let viewModel = BooksViewModel(repository: PreviewBooksRepositoryImpl())
		let book = Book(
			title: "Preview Book",
			authors: [Book.Author(name: "Writer 1"), Book.Author(name: "Writer 2")],
			coverId: 123456
		)
		viewModel.state = .loaded([book])

		return viewModel
	}

	static var previewForErrorState: BooksViewModel {
		let viewModel = BooksViewModel(repository: PreviewBooksRepositoryImpl())
		viewModel.state = .error("No Sci-fi books available")

		return viewModel
	}
}
