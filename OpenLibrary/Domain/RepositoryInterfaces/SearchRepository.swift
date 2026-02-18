//
//  SearchRepository.swift
//  OpenLibrary
//
//  Created by Suresh Gurung on 17/02/2026.
//

protocol SearchRepository {
    func searchBooks(query: String, offset: Int, pageSize: Int) async throws -> [Book]
}
