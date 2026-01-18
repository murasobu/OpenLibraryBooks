# OpenLibraryBooks

This is a simple SwiftUI app that fetches and displays a list of books from the Open Library API.

# Getting Started

1. Open the OpenLibrary.xcodeproj in Xcode (minimum version Xcode 14 since the project supports iOS 16 above).
2. Run the OpenLibrary scheme and target on a simulator or device.

# Project Structure

The main components of the project are Domain, Data and Presentation whose folders are inside the SciFiLibrary folder in Xcode.
1. Domain: Contains the Book model representing the book data.
2. Data: Contains the Repository class which handles fetching books from the network and caching them locally. It also contains the Networking code which performs the actual network calls and the local storage code which handles saving and retrieving cached data.
3. Presentation: Contains the SwiftUI views and ViewModel managing the UI state.

# Architecture
The app follows MVVM architecture for presentation with repository pattern handling the data fetching logic for single source of truth.
1. View is kept simple and only responsible for displaying data and forwarding user interactions to the ViewModel.
2. ViewModel manages the UI state (loading, loaded, error) and communicates with repository.
3. Repository acts as the single source of truth for books. It is responsible for fetching books from the network, caching them locally and then deciding what to return when network fails.

# External Frameworks

The project uses Swift Package Manager to manages 3rd party libraries. This is the list of frameworks used.
1. [Kingfisher](https://github.com/onevcat/Kingfisher) -> This framework loads and caches the images from web.
