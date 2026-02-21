//
//  SearchResponse.swift
//  OpenLibrary
//
//  Created by Suresh Gurung on 17/02/2026.
//

struct SearchResponse: Decodable {
    let books: [Book]

    enum CodingKeys: String, CodingKey {
        case books = "docs"
    }
}
