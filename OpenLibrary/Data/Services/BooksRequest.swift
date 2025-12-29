//
//  BooksRequest.swift
//  OpenLibrary
//
//  Created by Santa Gurung on 19/12/2025.
//

import Foundation

struct BooksRequest: Request {

	private let genre: Genre

	init(genre: Genre) {
		self.genre = genre
	}

	var path: String {
		return "subjects/\(genre.rawValue).json"
	}

	var query: String {
		return "limit=20"
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
