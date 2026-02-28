//
//  GenreRepositoryImpl.swift
//  OpenLibrary
//
//  Created by Santa Gurung on 19/12/2025.
//

struct GenreRepositoryImpl {

	private let genreService: GenreService
	private let localStorage: LocalStorage

	init(genreService: GenreService, localStorage: LocalStorage) {
		self.genreService = genreService
		self.localStorage = localStorage
	}
}

extension GenreRepositoryImpl: GenreRepository {

	func fetchBooks(genre: Genre, offset: Int, pageSize: Int) async throws -> [Book] {
		var errorToThrow: Error?

		do {
			let books = try await genreService.getbooks(genre: genre, offset: offset, pageSize: pageSize)

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

struct PreviewBooksRepositoryImpl: GenreRepository {

	func fetchBooks(genre: Genre, offset: Int, pageSize: Int) async throws -> [Book] {
		return []
	}
}
