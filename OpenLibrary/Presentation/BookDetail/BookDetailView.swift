//
//  BookDetailView.swift
//  OpenLibrary
//
//  Created by Suresh Gurung on 30/01/2026.
//

import SwiftUI
import Kingfisher

struct BookDetailView: View {

    @ObservedObject var viewModel: BookDetailViewModel

    var body: some View {
        VStack(alignment: .leading) {
            switch viewModel.state {
            case .loading:
                ProgressView("Books Loading")
            case .error(let message):
                ErrorView(message: message)
            case .loaded:
                ScrollView {
                    // Cover carousel at the top
                    let coverURLs = viewModel.coverURLs
                    TabView {
                        ForEach(coverURLs, id: \.self) { url in
                            KFImage(url)
                                .placeholder {
                                    ProgressView()
                                }
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .clipped()
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .padding(.horizontal)
                        }
                    }
                    .frame(height: 300)
                    .tabViewStyle(.page)

                    Text(viewModel.synopsis)
                        .padding()

                    Spacer()
                }
            }
        }
        .task {
            await viewModel.getBookDetail()
        }
        .navigationTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
