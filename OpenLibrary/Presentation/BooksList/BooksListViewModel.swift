//
//  BooksListViewModel.swift
//  OpenLibrary
//
//  Created by Santa Gurung on 19/12/2025.
//

import Combine
import Foundation

enum BooksViewState: Equatable {
	case loading
	case loaded([Book])
	case error(String)
}

@MainActor
final class BooksListViewModel: ObservableObject {

	@Published private(set) var state: BooksViewState = .loading
	@Published var selectedGenre: Genre
    @Published private(set) var offset: Int = 0
    @Published private(set) var pageSize: Int = 20
    var isLoadingMore: Bool = false
    private let repository: BooksRepository
    private var fetchedBooks: [Book] = []

    init(repository: BooksRepository, selectedGenre: Genre = .scienceFiction) {
		self.repository = repository
        self.selectedGenre = selectedGenre
	}

    func getBooks() async {
        state = .loading
        offset = 0
        fetchedBooks = []
		do {
			fetchedBooks = try await repository.fetchBooks(genre: selectedGenre, offset: 0, pageSize: 20)
			state = .loaded(fetchedBooks)
            offset += pageSize
		} catch {
			state = .error(error.localizedDescription)
		}
	}

    func getMoreBooks() async {
        isLoadingMore = true

        defer { isLoadingMore = false }

        do {
            let books = try await repository.fetchBooks(genre: selectedGenre, offset: offset, pageSize: pageSize)
            fetchedBooks.append(contentsOf: books)
            state = .loaded(fetchedBooks)
            offset += pageSize
        } catch {
            state = .error(error.localizedDescription)
        }
    }
}

// MARK: - ViewModels for Previews

extension BooksListViewModel {

	static var previewForLoadingState: BooksListViewModel {
		let viewModel = BooksListViewModel(repository: PreviewBooksRepositoryImpl())
		viewModel.state = .loading

		return viewModel
	}

	static var previewForLoadedState: BooksListViewModel {
		let viewModel = BooksListViewModel(repository: PreviewBooksRepositoryImpl())
		let book = Book(
            id: "1",
			title: "Preview Book",
            synopsis: "",
			authors: ["Writer 1", "Writer 2"],
			coverId: 123456
		)
		viewModel.state = .loaded([book])

		return viewModel
	}

	static var previewForErrorState: BooksListViewModel {
		let viewModel = BooksListViewModel(repository: PreviewBooksRepositoryImpl())
		viewModel.state = .error("No Sci-fi books available")

		return viewModel
	}
}
