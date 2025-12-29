//
//  Request.swift
//  OpenLibrary
//
//  Created by Santa Gurung on 19/12/2025.
//
import Foundation

protocol Request {
	var base: String { get }
	var path: String { get }
	var query: String { get }
	var urlRequest: URLRequest { get throws }
}

extension Request {
	var base: String { "https://openlibrary.org/" }
}
