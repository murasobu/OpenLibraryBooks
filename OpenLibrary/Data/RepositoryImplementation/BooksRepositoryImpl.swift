//
//  BooksRepositoryImpl.swift
//  OpenLibrary
//
//  Created by Santa Gurung on 19/12/2025.
//

struct BooksRepositoryImpl {

	private let booksService: BooksService
	private let localStorage: LocalStorage

	init(booksService: BooksService, localStorage: LocalStorage) {
		self.booksService = booksService
		self.localStorage = localStorage
	}
}

extension BooksRepositoryImpl: BooksRepository {

	func fetchBooks(genre: Genre, offset: Int, pageSize: Int) async throws -> [Book] {
		var errorToThrow: Error?

		do {
			let books = try await booksService.getbooks(genre: genre, offset: offset, pageSize: pageSize)

			// Once the books are fetched from BE, also store them locally
			localStorage.save(books: books, genre: genre)
			return books
		} catch {
			errorToThrow = error
		}

		// return locally stored book when api call fails
		do {
			return try localStorage.loadBooks(genre: genre)
		} catch {
			if let errorToThrow {
				throw errorToThrow
			}
		}
		return []
	}
}

// MARK: - Repositories for Previews

struct PreviewBooksRepositoryImpl: BooksRepository {

	func fetchBooks(genre: Genre, offset: Int, pageSize: Int) async throws -> [Book] {
		return []
	}
}
