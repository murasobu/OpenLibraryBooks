//
//  BookDetailRepository.swift
//  OpenLibrary
//
//  Created by Suresh Gurung on 13/03/2026.
//

protocol BookDetailRepository {
    func getBookDetail(id: String) async throws -> BookDetail
}
