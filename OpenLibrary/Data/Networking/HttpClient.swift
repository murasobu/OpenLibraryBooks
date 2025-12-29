//
//  HttpClient.swift
//  OpenLibrary
//
//  Created by Santa Gurung on 19/12/2025.
//

import Foundation

protocol HttpClient {
	func getResult(from urlRequest: URLRequest) async throws -> Data
}
