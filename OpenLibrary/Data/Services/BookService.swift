//
//  BookService.swift
//  OpenLibrary
//
//  Created by Suresh Gurung on 13/03/2026.
//

import Foundation

protocol BookService {
    func fetchBookDetail(id: String) async throws -> BookDetail
}

struct BookServiceImpl: BookService {

    private let client: HttpClient

	init(client: HttpClient = URLSessionClient()) {
		self.client = client
	}

    func fetchBookDetail(id: String) async throws -> BookDetail {
        let request = BookRequest(id: id)
        let data = try await client.getResult(from: request.urlRequest)

        guard let responseObject = try? JSONDecoder().decode(BookDetail.self, from: data) else {
            throw NetworkError.decodingError
        }
        return responseObject
    }
}
