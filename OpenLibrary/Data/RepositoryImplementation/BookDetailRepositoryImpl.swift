//
//  BookDetailRepositoryImpl.swift
//  OpenLibrary
//
//  Created by Suresh Gurung on 13/03/2026.
//

struct BookDetailRepositoryImpl {

    private let bookDetailService: BookService

    init(bookDetailService: BookService) {
        self.bookDetailService = bookDetailService
    }
}

extension BookDetailRepositoryImpl: BookDetailRepository {

    func getBookDetail(id: String) async throws -> BookDetail {
        try await bookDetailService.fetchBookDetail(id: id)
    }
}
