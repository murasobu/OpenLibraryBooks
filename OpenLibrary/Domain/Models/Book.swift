//
//  Book.swift
//  OpenLibrary
//
//  Created by Santa Gurung on 19/12/2025.
//

import Foundation

struct Book: Codable, Identifiable, Equatable, Hashable {
    
    struct Author: Codable, Equatable, Hashable {
        let name: String
    }
    
    let id: String
    let title: String
    let synopsis: String?
    let authors: [Author]
    let coverId: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "key"
        case title
        case synopsis = "description"
        case authors
        case coverId = "cover_id"
    }
    
    var coverURL: URL? {
        return URL(string: "https://covers.openlibrary.org/b/id/\(coverId)-M.jpg")
    }
}

// MARK: - Sample Data for Testing and Previews

extension Book {

	static let sampleBooks: [Book] = [
		Book(
            id: "1",
            title: "Dune",
            synopsis: "",
			authors: [Author(name: "Frank Herbert")],
			coverId: 8254151
		),
		Book(
            id: "2",
			title: "Neuromancer",
            synopsis: "",
			authors: [Author(name: "William Gibson")],
			coverId: 8231996
		),
		Book(
            id: "3",
			title: "Foundation",
            synopsis: "",
			authors: [Author(name: "Isaac Asimov")],
			coverId: 8226191
		)
	]
}
