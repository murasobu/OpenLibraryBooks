//
//  NetworkError.swift
//  OpenLibrary
//
//  Created by Santa Gurung on 19/12/2025.
//

import Foundation

enum NetworkError: Error, LocalizedError {
	case noInternetConnection
	case invalidUrlRequest
	case statusError
	case decodingError

	var errorDescription: String? {
		switch self {
		case .noInternetConnection:
			return "No Internet Connection. Please check your network and try again."
		case .invalidUrlRequest:
			return "Invalid URL Request"
		case .statusError:
			return "The server responded with an invalid status. Please try again."
		case .decodingError:
			return "Decoding Error"
		}
	}
}
