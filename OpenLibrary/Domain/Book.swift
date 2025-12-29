//
//  Book.swift
//  OpenLibrary
//
//  Created by Santa Gurung on 19/12/2025.
//

import Foundation

struct Book: Codable, Identifiable, Equatable {

	struct Author: Codable, Equatable {
		let name: String
	}

	let id: UUID = UUID()
	let title: String
	let authors: [Author]
	let coverId: Int

	enum CodingKeys: String, CodingKey {
		case title
		case authors
		case coverId = "cover_id"
	}

	var coverURL: URL? {
		return URL(string: "https://covers.openlibrary.org/b/id/\(coverId)-M.jpg")
	}
}

// MARK: - Root object from Backend response

struct BooksResponse: Decodable {
	let books: [Book]

	enum CodingKeys: String, CodingKey {
		case books = "works"
	}
}

// MARK: - Sample Data for Testing and Previews

extension Book {

	static let sampleBooks: [Book] = [
		Book(
			title: "Dune",
			authors: [Author(name: "Frank Herbert")],
			coverId: 8254151
		),
		Book(
			title: "Neuromancer",
			authors: [Author(name: "William Gibson")],
			coverId: 8231996
		),
		Book(
			title: "Foundation",
			authors: [Author(name: "Isaac Asimov")],
			coverId: 8226191
		)
	]
}
