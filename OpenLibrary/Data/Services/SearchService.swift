import Foundation

protocol SearchService {
    func search(query: String, offset: Int, limit: Int) async throws -> [Book]
}

struct SearchServiceImpl: SearchService {

    private let client: HttpClient

    init(client: HttpClient = URLSessionClient()) {
        self.client = client
    }

    func search(query: String, offset: Int, limit: Int) async throws -> [Book] {
        let request = SearchRequest(userQuery: query, offset: offset, pageSize: limit)
        do {
            let data = try await client.getResult(from: request.urlRequest)

            guard let responseObject = try? JSONDecoder().decode(SearchResponse.self, from: data) else {
                throw NetworkError.decodingError
            }
            return responseObject.books
        }
    }
}
