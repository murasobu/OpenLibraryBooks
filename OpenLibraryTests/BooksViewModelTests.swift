//
//  BooksViewModelTests.swift
//  OpenLibrary
//
//  Created by Santa Gurung on 28/12/2025.
//

import XCTest
@testable import OpenLibrary

@MainActor
final class BooksViewModelTests: XCTestCase {

	var sut: BooksViewModel!

	override func tearDown() {
        super.tearDown()
		sut = nil
	}

	func test_fetchBooks_setsLoadingState_beforeRepositoryCall() async {
		sut = BooksViewModel(repository: MockBooksRepository(result: .success([])))
		XCTAssertEqual(sut.state, .loading)
	}
    
	func test_getBooks_setsLoadedState_whenRepositorySuccessful() async {
		sut = BooksViewModel(repository: MockBooksRepository(result: .success(Book.sampleBooks)))
		await sut.getBooks()
		XCTAssertEqual(sut.state, .loaded(Book.sampleBooks))
	}

	func test_getBooks_setsErrorState_whenRepositoryFails() async {
		sut = BooksViewModel(repository: MockBooksRepository(result: .failure(URLError(.notConnectedToInternet))))
		await sut.getBooks()
		XCTAssertEqual(sut.state, .error(URLError(.notConnectedToInternet).localizedDescription))
	}
}

// MARK: - BooksRepository Mock

class MockBooksRepository: BooksRepository {

	enum Result {
		case success([Book])
		case failure(Error)
	}

	let result: Result

	init(result: Result) {
		self.result = result
	}

	func fetchBooks(genre: Genre) async throws -> [Book] {
		switch result {
		case .success(let books):
			return books
		case .failure(let error):
			throw error
		}
	}
}
