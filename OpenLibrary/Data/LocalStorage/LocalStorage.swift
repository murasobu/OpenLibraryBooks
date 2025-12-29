//
//  LocalStorage.swift
//  OpenLibrary
//
//  Created by Santa Gurung on 19/12/2025.
//

protocol LocalStorage {
	func loadBooks(genre: Genre) throws -> [Book]
	func save(books: [Book], genre: Genre)
}
