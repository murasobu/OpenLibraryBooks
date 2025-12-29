//
//  URLSessionClient.swift
//  OpenLibrary
//
//  Created by Santa Gurung on 19/12/2025.
//

import Foundation

protocol URLSessionProtocol {
	func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol { }


// MARK: - URLSessionClient

struct URLSessionClient {

	private let session: URLSessionProtocol

	init(session: URLSessionProtocol = URLSession.shared) {
		self.session = session
	}
}

extension URLSessionClient: HttpClient {

	func getResult(from urlRequest: URLRequest) async throws -> Data {
		do {
			let (data, response) = try await session.data(for: urlRequest)

			guard let response = response as? HTTPURLResponse,
				  response.statusCode == 200 else {
				throw NetworkError.statusError
			}
			return data

		} catch URLError.notConnectedToInternet {
			throw NetworkError.noInternetConnection
		}
	}
}
