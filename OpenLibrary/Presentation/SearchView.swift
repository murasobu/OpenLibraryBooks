//
//  SearchView.swift
//  OpenLibrary
//
//  Created by Suresh Gurung on 30/01/2026.
//

import SwiftUI

struct SearchView: View {

    @State private var path = NavigationPath()
    @State private var query: String = ""

    let booksRepository: BooksRepository
    let genres: [Genre] = Genre.allCases
    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 120), spacing: 12)
    ]
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(genres, id: \.self) { genre in
                            Button {
                                path.append(genre)
                            } label: {
                                GenreCell(title: genre.title)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                }
                .padding(.top)
                .padding(.bottom, 32)
            }
            .scrollIndicators(.hidden)
            .scrollBounceBehavior(.always)
            .navigationTitle("Search")
            .searchable(text: $query, placement: .automatic, prompt: "Search books")
            .submitLabel(.search)
            .navigationDestination(for: Genre.self) { genre in
                BooksView(
                    viewModel: BooksViewModel(
                        repository: booksRepository,
                        selectedGenre: genre
                    )
                )
            }
        }
    }
}

struct GenreCell: View {
    
    let title: String

    var body: some View {
        Text(title)
            .font(.subheadline)
            .frame(maxWidth: .infinity, maxHeight: 80)
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color(.systemGray6))
            )
    }
}

//#Preview {
//    SearchView()
//}
