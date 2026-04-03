//
//  BookDetailViewModel.swift
//  OpenLibrary
//
//  Created by Suresh Gurung on 01/02/2026.
//

import Combine
import Foundation

enum BookDetailViewState: Equatable {
    case loading
    case loaded(BookDetail)
    case error(String)
}

@MainActor
final class BookDetailViewModel: ObservableObject {

    var title: String { book?.title ?? "" }
    var synopsis: String { book?.description ?? "" }
    var coverURLs: [URL] { book?.coverURLs ?? [] }

    @Published private(set) var state: BookDetailViewState = .loading
    private let repository: BookDetailRepository
    private let bookId: String
    private var book: BookDetail?

    init(bookId: String, repository: BookDetailRepository) {
        self.bookId = bookId
        self.repository = repository
    }

    func getBookDetail() async {
        do {
            let fetchedBook = try await repository.getBookDetail(id: bookId)
            book = fetchedBook
            state = .loaded(fetchedBook)
        } catch {
            state = .error(error.localizedDescription)
        }
    }
}
