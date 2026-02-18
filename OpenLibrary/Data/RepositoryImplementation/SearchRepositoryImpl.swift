//
//  SearchRepositoryImpl.swift
//  OpenLibrary
//
//  Created by Suresh Gurung on 17/02/2026.
//

struct SearchRepositoryImpl {
    
    private let searchService: SearchService
    
    init(searchService: SearchService) {
        self.searchService = searchService
    }
}

extension SearchRepositoryImpl: SearchRepository {
    
    func searchBooks(query: String, offset: Int, pageSize: Int) async throws -> [Book] {
        try await searchService.search(query: query, offset: offset, limit: pageSize)
    }
}
