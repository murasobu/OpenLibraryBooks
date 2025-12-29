//
//  BooksRepositoryTests.swift
//  OpenLibrary
//
//  Created by Santa Gurung on 19/12/2025.
//

import XCTest
@testable import OpenLibrary

final class BooksRepositoryTests: XCTestCase {

	var sut: BooksRepositoryImpl!

	override func tearDown() {
		sut = nil
	}

	func test_fetchBooks_returnsBooksFromWorkingService() async throws {
		// Given the subject under test with a working books service and empty local storage
		let booksService = await MockBooksService(result: .success(Book.sampleBooks))
		let localStorage = MockLocalStorage(result: .empty)
		sut = await BooksRepositoryImpl(booksService: booksService, localStorage: localStorage)

		// Fetch books from the working service
		let books = try await sut.fetchBooks(genre: .scienceFiction)
		XCTAssertEqual(books.count, 3)
		XCTAssertEqual(books.first?.title, "Dune")
	}

	func test_fetchBooks_returnsBooksFromLocalStorageOnServiceFailure() async throws {
		// Given the subject under test with a failing service and pre-loaded local storage
		let booksService = MockBooksService(result: .failure(URLError(.notConnectedToInternet)))
		let localStorage = await MockLocalStorage(result: .loaded(Book.sampleBooks))
		sut = await BooksRepositoryImpl(booksService: booksService, localStorage: localStorage)

		// Testing if the locally stored books are fetched when the service fails
		let books = try await sut.fetchBooks(genre: .scienceFiction)
		XCTAssertEqual(books.count, 3)
		XCTAssertEqual(books.first?.title, "Dune")
	}
}

// MARK: - BooksService Mock

final class MockBooksService: BooksService {

	enum Result {
		case success([Book])
		case failure(Error)
	}

	let result: Result

	init(result: Result) {
		self.result = result
	}

	override func getbooks(genre: Genre) async throws -> [Book] {
		switch result {
		case .success(let books):
			return books
		case .failure(let error):
			throw error
		}
	}
}

// MARK: - LocalStorage Mock

final class MockLocalStorage: LocalStorage {

	enum Result {
		case loaded([Book])
		case empty
	}

	let result: Result

	init(result: Result) {
		self.result = result
	}

	func loadBooks(genre: Genre) throws -> [Book] {
		switch result {
		case .loaded(let books):
			return books
		case .empty:
			return []
		}
	}

	func save(books: [Book], genre: Genre) {

	}
}
