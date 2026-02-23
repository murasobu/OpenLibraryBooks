//
//  SearchView.swift
//  OpenLibrary
//
//  Created by Suresh Gurung on 30/01/2026.
//

import SwiftUI

struct SearchView: View {

    @ObservedObject var viewModel: SearchViewModel
    @EnvironmentObject var coordinator: Coordinator
    @State private var query: String = ""

    private let genres: [Genre] = Genre.allCases
    private let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 120), spacing: 12)
    ]

    var body: some View {
        Group {
            switch viewModel.state {
            case .genres:
                GenresGridView(
                    genres: genres,
                    columns: columns
                ) { genre in
                    coordinator.goTo(screen: .booksList(genre))
                }

            case .loading:
                ProgressView("Books Loading")

            case .loaded(let books):
                List(books) { book in
                    Button {
                        coordinator.goTo(screen: .bookDetails(book))
                    } label: {
                        BookRow(book: book)
                    }
                }

            case .empty(let message):
                SearchErrorView(message: message)
            }
        }
        .navigationTitle("Search")
        .searchable(text: $query, placement: .automatic, prompt: "Search books")
        .submitLabel(.search)
        .onSubmit(of: .search) {
            Task {
                await viewModel.search(query: query)
            }
        }
        .onChange(of: query, initial: false) { oldValue, newValue in
            guard oldValue != newValue else {
                return
            }
            viewModel.loadDefaultState()
        }
    }
}

// MARK: - Grid view containing genres

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

// MARK: - Cell containing genre

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

// MARK: - Search view when no books are loaded

struct SearchErrorView: View {

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
