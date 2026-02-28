//
//  GenreRepository.swift
//  OpenLibrary
//
//  Created by Santa Gurung on 19/12/2025.
//

protocol GenreRepository {
    func fetchBooks(genre: Genre, offset: Int, pageSize: Int) async throws -> [Book]
}
