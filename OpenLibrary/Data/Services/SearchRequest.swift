//
//  SearchRequest.swift
//  OpenLibrary
//
//  Created by Suresh Gurung on 17/02/2026.
//

import Foundation

struct SearchRequest: Request {

    private let userQuery: String
    private let offset: Int
    private let pageSize: Int

    init(userQuery: String, offset: Int, pageSize: Int) {
        self.userQuery = userQuery
        self.offset = offset
        self.pageSize = pageSize
    }

    var path: String {
        return "search.json"
    }

    var query: String {
        return "?q=\(userQuery)&offset=\(offset)&limit=\(pageSize)"
    }

    var urlRequest: URLRequest {
        get throws {
            guard let url = URL(string: base + path + query) else {
                throw NetworkError.invalidUrlRequest
            }
            return URLRequest(url: url)
        }
    }
}
