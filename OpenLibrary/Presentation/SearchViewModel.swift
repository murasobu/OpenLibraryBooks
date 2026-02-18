//
//  SearchViewModel.swift
//  OpenLibrary
//
//  Created by Suresh Gurung on 17/02/2026.
//

import Combine
import Foundation

enum SearchViewState: Equatable {
    case genres
    case loading
    case loaded([Book])
    case empty(String)
}

@MainActor
final class SearchViewModel: ObservableObject {
    
    @Published private(set) var state: SearchViewState = .genres
    
    private let searchRepository: SearchRepository
    private var searchedBooks: [Book] = []
    
    init(searchRepository: SearchRepository) {
        self.searchRepository = searchRepository
    }
    
    func search(query: String) async {
        state = .loading
        do {
            searchedBooks = try await searchRepository.searchBooks(query: query, offset: 0, pageSize: 20)
            if searchedBooks.isEmpty {
                state = .empty("No books found for '\(query)'")
            } else {
                state = .loaded(searchedBooks)
            }
        } catch {
            state = .empty(error.localizedDescription)
        }
    }
    
    func loadDefaultState() {
        state = .genres
    }
}
