//
//  BookDetailViewModel.swift
//  OpenLibrary
//
//  Created by Suresh Gurung on 01/02/2026.
//

import Combine
import Foundation

@MainActor
final class BookDetailViewModel: ObservableObject {
    
    var title: String { book.title }
    var description: String { book.title }
    
    private let book: Book
    
    init(book: Book) {
        self.book = book
    }
}
