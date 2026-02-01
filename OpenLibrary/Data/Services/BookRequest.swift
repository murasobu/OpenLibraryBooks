//
//  BookRequest.swift
//  OpenLibrary
//
//  Created by Suresh Gurung on 31/01/2026.
//

import Foundation

struct BookRequest: Request {
    
    private let id: String
    
    var path: String {
        return "works/\(id).json"
    }
    
    var query: String
    
    var urlRequest: URLRequest {
        get throws {
            guard let url = URL(string: base + path) else {
                throw NetworkError.invalidUrlRequest
            }
            return URLRequest(url: url)
        }
    }
}
