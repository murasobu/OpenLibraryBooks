//
//  BookDetail.swift
//  OpenLibrary
//
//  Created by Suresh Gurung on 14/03/2026.
//

import Foundation

struct BookDetail: Decodable, Equatable {

    let key: String
    let description: String
    let title: String
    let covers: [Int]

    var coverURLs: [URL] {
        covers.compactMap { URL(string: "https://covers.openlibrary.org/b/id/\($0)-M.jpg") }
    }
}
