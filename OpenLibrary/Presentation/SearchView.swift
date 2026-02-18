//
//  SearchView.swift
//  OpenLibrary
//
//  Created by Suresh Gurung on 30/01/2026.
//

import SwiftUI

struct SearchView: View {

    @ObservedObject var viewModel: SearchViewModel
    @State private var path = NavigationPath()
    @State private var query: String = ""

    let navigationFactory: SearchNavigationFactory
    let genres: [Genre] = Genre.allCases
    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 120), spacing: 12)
    ]

    var body: some View {
        NavigationStack(path: $path) {
            Group {
                switch viewModel.state {
                case .genres:
                    GenresGridView(
                        genres: genres,
                        columns: columns
                    ) { genre in
                        path.append(genre)
                    }

                case .loading:
                    ProgressView()

                case .loaded(let books):
                    List(books) { book in
                        NavigationLink(value: book) {
                            BookRow(book: book)
                        }
                    }
                    
                case .empty(let message):
                    EmptyView(message: message)
                }
            }
            .navigationTitle("Search")
            .searchable(text: $query, placement: .automatic, prompt: "Search books")
            .submitLabel(.search)
            .navigationDestination(for: Genre.self) { genre in
                navigationFactory.destination(for: genre)
            }
        }
        .onSubmit(of: .search) {
            let q = query.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !q.isEmpty else { return }
            Task {
                await viewModel.search(query: q)
            }
        }
        .onChange(of: query) { newValue in
            if newValue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                viewModel.loadDefaultState()
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

struct GenresGridView: View {
    let genres: [Genre]
    let columns: [GridItem]
    let onSelect: (Genre) -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(genres, id: \.self) { genre in
                        Button {
                            onSelect(genre)
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
    }
}

struct EmptyView: View {
    
    let message: String

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "book")
                .font(.largeTitle)
                .foregroundStyle(.secondary)
            Text(message)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
