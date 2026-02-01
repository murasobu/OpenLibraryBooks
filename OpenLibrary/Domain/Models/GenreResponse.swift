//
//  GenreResponse.swift
//  OpenLibrary
//
//  Created by Suresh Gurung on 01/02/2026.
//

struct GenreResponse: Decodable {
    let books: [Book]

    enum CodingKeys: String, CodingKey {
        case books = "works"
    }
}
