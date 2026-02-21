//
//  BookDetailView.swift
//  OpenLibrary
//
//  Created by Suresh Gurung on 30/01/2026.
//

import SwiftUI

struct BookDetailView: View {

    let book: Book

    var body: some View {
        VStack(alignment: .leading) {
            Text(book.title)
            Text(book.synopsis ?? "No synopsis available.")
        }
    }
}
