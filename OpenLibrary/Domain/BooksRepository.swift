//
//  BooksRepository.swift
//  OpenLibrary
//
//  Created by Santa Gurung on 19/12/2025.
//

protocol BooksRepository {
    func fetchBooks(genre: Genre, offset: Int, pageSize: Int) async throws -> [Book]
}
