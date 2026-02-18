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
    let authors: [String]
    let coverId: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "key"
        case title
        case synopsis = "description"
        case authors
        case coverId = "cover_id"
    }
    
    private enum FallbackCodingKeys: String, CodingKey {
        case authorFromSearch = "author_name"
        case coverIdFromSearch = "cover_i"
    }

    var coverURL: URL? {
        return URL(string: "https://covers.openlibrary.org/b/id/\(coverId)-M.jpg")
    }
}

extension Book {
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let fallbackContainer = try decoder.container(keyedBy: FallbackCodingKeys.self)

        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.synopsis = try container.decodeIfPresent(String.self, forKey: .synopsis)
        
        if let authorObjects = try container.decodeIfPresent([Author].self, forKey: .authors) {
            self.authors = authorObjects.map { $0.name }
        } else {
            self.authors = try fallbackContainer.decode([String].self, forKey: .authorFromSearch)
        }
        if let cover = try container.decodeIfPresent(Int.self, forKey: .coverId) {
            self.coverId = cover
        } else {
            self.coverId = try fallbackContainer.decode(Int.self, forKey: .coverIdFromSearch)
        }
    }
}

// MARK: - Sample Data for Testing and Previews

extension Book {

	static let sampleBooks: [Book] = [
		Book(
            id: "1",
            title: "Dune",
            synopsis: "",
			authors: ["Frank Herbert"],
			coverId: 8254151
		),
		Book(
            id: "2",
			title: "Neuromancer",
            synopsis: "",
			authors: ["William Gibson"],
			coverId: 8231996
		),
		Book(
            id: "3",
			title: "Foundation",
            synopsis: "",
			authors: ["Isaac Asimov"],
			coverId: 8226191
		)
	]
}
