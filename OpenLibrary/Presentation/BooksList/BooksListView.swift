//
//  BooksListView.swift
//  OpenLibrary
//
//  Created by Santa Gurung on 19/12/2025.
//

import SwiftUI
import Kingfisher

struct BooksListView: View {

	@ObservedObject var viewModel: BooksListViewModel
    @EnvironmentObject var coordinator: Coordinator
	private let isPreview: Bool

	init(viewModel: BooksListViewModel, isPreview: Bool = false) {
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
                    Button {
                        coordinator.goTo(screen: .bookDetails(book))
                    } label: {
                        BookRow(book: book)
                            .onAppear {
                                if book == books.last {
                                    Task { await viewModel.getMoreBooks() }
                                }
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
		.task {
			guard !isPreview else { return }
			await viewModel.getBooks()
		}
        .navigationTitle(viewModel.selectedGenre.title)
		.toolbar {
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
				Text(book.authors.joined(separator: ", "))
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
    BooksListView(viewModel: .previewForLoadingState, isPreview: true)
}

#Preview("Loaded State") {
    BooksListView(viewModel: .previewForLoadedState, isPreview: true)
}

#Preview("Error State") {
    BooksListView(viewModel: .previewForErrorState, isPreview: true)
}
