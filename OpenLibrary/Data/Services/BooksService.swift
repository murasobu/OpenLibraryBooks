//
//  BooksService.swift
//  OpenLibrary
//
//  Created by Santa Gurung on 19/12/2025.
//

import Foundation

protocol BooksService {
    func getbooks(genre: Genre, offset: Int, pageSize: Int) async throws -> [Book]
}

struct BooksServiceImpl: BooksService {

	private let client: HttpClient

	init(client: HttpClient = URLSessionClient()) {
		self.client = client
	}

    func getbooks(genre: Genre, offset: Int, pageSize: Int) async throws -> [Book] {
		let request = BooksRequest(genre: genre, offset: offset, pageSize: pageSize)
		do {
			let data = try await client.getResult(from: request.urlRequest)

			guard let responseObject = try? JSONDecoder().decode(BooksResponse.self, from: data) else {
				throw NetworkError.decodingError
			}
			return responseObject.books
		}
	}
}
