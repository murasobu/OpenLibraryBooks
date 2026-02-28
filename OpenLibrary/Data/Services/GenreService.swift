//
//  GenreService.swift
//  OpenLibrary
//
//  Created by Santa Gurung on 19/12/2025.
//

import Foundation

protocol GenreService {
    func getbooks(genre: Genre, offset: Int, pageSize: Int) async throws -> [Book]
}

struct GenreServiceImpl: GenreService {

	private let client: HttpClient

	init(client: HttpClient = URLSessionClient()) {
		self.client = client
	}

    func getbooks(genre: Genre, offset: Int, pageSize: Int) async throws -> [Book] {
		let request = GenreRequest(genre: genre, offset: offset, pageSize: pageSize)
		do {
			let data = try await client.getResult(from: request.urlRequest)

			guard let responseObject = try? JSONDecoder().decode(GenreResponse.self, from: data) else {
				throw NetworkError.decodingError
			}
			return responseObject.books
		}
	}
}
