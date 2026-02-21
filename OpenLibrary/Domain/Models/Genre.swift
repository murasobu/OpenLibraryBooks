//
//  Genre.swift
//  OpenLibrary
//
//  Created by Santa Gurung on 24/12/2025.
//

enum Genre: String, CaseIterable {
	case scienceFiction = "science_fiction"
	case romance
	case action
	case trueCrime = "true_crime"
    case horror
    case thriller
    case mysteryAndDetective = "mystery_and_detective_stories"
    case autobiography

    var title: String {
        switch self {
        case .scienceFiction: "Science Fiction"
        case .romance: "Romance"
        case .action: "Action"
        case .trueCrime: "True Crime"
        case .horror: "Horror"
        case .thriller: "Thriller"
        case .mysteryAndDetective: "Mystery and Detective Stories"
        case .autobiography: "Autobiography"
        }
    }
}
