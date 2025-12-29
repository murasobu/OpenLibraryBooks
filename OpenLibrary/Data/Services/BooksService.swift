//
//  BooksService.swift
//  OpenLibrary
//
//  Created by Santa Gurung on 19/12/2025.
//

import Foundation

class BooksService {

	private let client: HttpClient

	init(client: HttpClient = URLSessionClient()) {
		self.client = client
	}

	func getbooks(genre: Genre) async throws -> [Book] {
		let request = BooksRequest(genre: genre)
		do {
			let data = try await client.getResult(from: request.urlRequest)

			guard let responseObject = try? JSONDecoder().decode(BooksResponse.self, from: data) else {
				throw NetworkError.decodingError
			}
			return responseObject.books
		}
	}
}
