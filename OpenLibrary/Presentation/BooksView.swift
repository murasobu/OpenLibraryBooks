//
//  BooksView.swift
//  OpenLibrary
//
//  Created by Santa Gurung on 19/12/2025.
//

import SwiftUI
import Kingfisher

struct BooksView: View {

	@ObservedObject var viewModel: BooksViewModel
	let isPreview: Bool

	init(viewModel: BooksViewModel, isPreview: Bool = false) {
		self.viewModel = viewModel
		self.isPreview = isPreview
	}

	var body: some View {
		VStack {
			switch viewModel.state {
			case .loading:
				ProgressView("Books Loading")

			case .loaded(let books):
				List(books) { book in
					BookRow(book: book)
                        .onAppear {
                            if book == books.last {
                                Task { await viewModel.getMoreBooks() }
                            }
                        }
				}
                if viewModel.isLoadingMore {
                    ProgressView("Loading More")
                }

			case .error(let message):
				ErrorView(message: message)
			}
		}
		.task(id: viewModel.selectedGenre) {
			guard !isPreview else { return }
			await viewModel.getBooks()
		}
		.navigationTitle("Books")
		.toolbar {
			ToolbarItem(placement: .topBarLeading) {
				Picker("Genre", selection: $viewModel.selectedGenre) {
					ForEach(Genre.allCases, id: \.self) { genre in
						Text(genre.rawValue)
							.tag(genre)
					}
				}
				.pickerStyle(.menu)
			}

			ToolbarItem(placement: .topBarTrailing) {
				Button {
					Task { await viewModel.getBooks() }
				} label: {
					Image(systemName: "arrow.clockwise")
				}
			}
		}
	}
}

// MARK: - Single Book Row View

struct BookRow: View {

	let book: Book

	var body: some View {
		HStack {
            KFImage(book.coverURL)
                .placeholder {
                    Color.gray
                        .frame(width: 50, height: 70)
                }
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 70)

			VStack(alignment: .leading, spacing: 12) {
				Text(book.title)
					.font(.headline)
				Text(book.authors.map { $0.name }.joined(separator: ", "))
					.font(.caption)
			}
		}
	}
}

// MARK: - Error View

struct ErrorView: View {

	let message: String

	var body: some View {
		VStack(spacing: 16) {
			Image(systemName: "exclamationmark.triangle.fill")
				.resizable()
				.frame(width: 50, height: 50)
				.foregroundColor(.yellow)

			Text(message)
				.font(.headline)
				.multilineTextAlignment(.center)
				.padding()
		}
	}
}

// MARK: - Previews for different view states

#Preview("Loading State") {
	BooksView(viewModel: .previewForLoadingState, isPreview: true)
}

#Preview("Loaded State") {
	BooksView(viewModel: .previewForLoadedState, isPreview: true)
}

#Preview("Error State") {
	BooksView(viewModel: .previewForErrorState, isPreview: true)
}
