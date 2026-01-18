//
//  BooksRequest.swift
//  OpenLibrary
//
//  Created by Santa Gurung on 19/12/2025.
//

import Foundation

struct BooksRequest: Request {

	private let genre: Genre
    private let offset: Int
    private let pageSize: Int
    
    init(genre: Genre, offset: Int, pageSize: Int) {
		self.genre = genre
        self.offset = offset
        self.pageSize = pageSize
	}

	var path: String {
		return "subjects/\(genre.rawValue).json"
	}

	var query: String {
		return "offset=\(offset)&limit=\(pageSize)"
	}

	var urlRequest: URLRequest {
		get throws {
			guard let url = URL(string: base + path + "?" + query) else {
				throw NetworkError.invalidUrlRequest
			}
			return URLRequest(url: url)
		}
	}
}
