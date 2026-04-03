//
//  BookRequest.swift
//  OpenLibrary
//
//  Created by Suresh Gurung on 31/01/2026.
//

import Foundation

struct BookRequest: Request {

    private let id: String

    init(id: String) {
        self.id = id
    }

    var path: String {
        return "\(id).json"
    }

    var query: String {
        return ""
    }

    var urlRequest: URLRequest {
        get throws {
            guard let url = URL(string: base + path) else {
                throw NetworkError.invalidUrlRequest
            }
            return URLRequest(url: url)
        }
    }
}
