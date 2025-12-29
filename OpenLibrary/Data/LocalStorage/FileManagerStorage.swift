//
//  FileManagerStorage.swift
//  OpenLibrary
//
//  Created by Santa Gurung on 19/12/2025.
//

import Foundation

enum LocalStorageError: Error, LocalizedError {
	case noStoredBooks

	var errorDescription: String? {
		switch self {
		case .noStoredBooks:
			return "No stored books found"
		}
	}
}

final class FileManagerStorage {

	private let fileManager: FileManager

	init(fileManager: FileManager = .default) {
		self.fileManager = fileManager
	}

	func getFileURL(genre: Genre) throws -> URL {
		return try fileManager.url(
			for: .documentDirectory,
			in: .userDomainMask,
			appropriateFor: nil,
			create: false
		)
		.appending(path: "\(genre) books")
	}
}

extension FileManagerStorage: LocalStorage {

	func loadBooks(genre: Genre) throws -> [Book] {
		guard let data = try? Data(contentsOf: getFileURL(genre: genre)) else {
			throw LocalStorageError.noStoredBooks
		}

		let books = try JSONDecoder().decode([Book].self, from: data)
		guard !books.isEmpty else {
			throw LocalStorageError.noStoredBooks
		}
		return books
	}

	func save(books: [Book], genre: Genre) {
		let data = try? JSONEncoder().encode(books)
		try? data?.write(to: getFileURL(genre: genre))
	}
}
