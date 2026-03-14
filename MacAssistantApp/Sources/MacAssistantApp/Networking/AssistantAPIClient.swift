import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public struct AssistantRequest: Codable {
    public let prompt: String
    public let userId: String

    public init(prompt: String, userId: String) {
        self.prompt = prompt
        self.userId = userId
    }
}

public struct AssistantAPIResponse: Codable, Equatable {
    public struct Safety: Codable, Equatable {
        public let restrictedTopics: Bool
        public let dataScope: String
    }

    public let assistant: String
    public let userId: String
    public let allowed: Bool
    public let response: String
    public let safety: Safety
}

public final class AssistantAPIClient {
    public enum APIError: Error, LocalizedError {
        case invalidURL
        case invalidResponse
        case httpError(Int)

        public var errorDescription: String? {
            switch self {
            case .invalidURL: "Invalid assistant API URL."
            case .invalidResponse: "Invalid response from assistant API."
            case .httpError(let code): "Assistant API failed with status code \(code)."
            }
        }
    }

    private let baseURL: String
    private let session: URLSession

    public init(baseURL: String = "http://localhost:3000", session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
    }

    public func send(prompt: String, userId: String) async throws -> AssistantAPIResponse {
        guard let url = URL(string: "\(baseURL)/api/mac") else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(AssistantRequest(prompt: prompt, userId: userId))

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.httpError(httpResponse.statusCode)
        }

        return try JSONDecoder().decode(AssistantAPIResponse.self, from: data)
    }
}
