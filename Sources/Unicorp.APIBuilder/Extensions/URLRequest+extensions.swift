//
//  URLRequest+extensions.swift
//
//
//  Created by Ressier Mathilde on 15/03/2024.
//

import Foundation

// =============================================================================
// MARK: - Run
// =============================================================================

extension URLRequest {
    /// Send the URLRequest using the given `session`
    /// and return a decoded response
    public func send<T: Decodable>(
        session: URLSession = .shared,
        delegate: URLSessionTaskDelegate? = nil
    ) async throws -> T{
        let result = try await session.data(for: self, delegate: delegate)

        return try decodeResponse(data: result.0, response: result.1)
    }

    private func decodeResponse<T: Decodable>(
        data: Data?,
        response: URLResponse?,
        decoder: JSONDecoder = .init()
    ) throws -> T {
        guard let httpResponse = response else {
            print("No response on request")
            throw APIEndpointError.noResponse
        }

        guard let data = data else {
            print("No data on request result")
            throw APIEndpointError.noData
        }

        print(data.jsonPrettyPrintDescription ?? "nil")

        if let error = httpResponse.error {
            print("Error on response request: \(error))")
            throw error
        }

        do {
            let object = try decoder.decode(T.self, from: data)
            return object
        } catch {
            print("JSON error \(error)\n\(error.localizedDescription)")
            throw APIEndpointError.conversionFailed(data: data)
        }
    }
}

// =============================================================================
// MARK: - Configuration
// =============================================================================

extension URLRequest {
    /// Add headers fields to request
    mutating func add(headers: Encodable) {
        headers.stringDictionary?.forEach { (key, value) in
            self.addValue(value, forHTTPHeaderField: key)
        }
    }

    /// Set the content type of the request
    mutating func set(contentType: ContentType?) {
        if let type = contentType {
            self.setValue(type.value, forHTTPHeaderField: "Content-Type")
        }
    }

    mutating func set(requestType: RequestType) {
        self.httpMethod = requestType.rawValue
    }
}

// =============================================================================
// MARK: - Debug
// =============================================================================

extension URLRequest {
    func debug() {
        let method = self.httpMethod ?? "NO METHOD"
        let url = "\"\(String(describing: self))\""
        let body = "Body: \(self.httpBody?.jsonPrettyPrintDescription ?? "{}")"
        let header = "Headers: \(self.allHTTPHeaderFields?.stringDictionary?.description ?? "{}")"

        let content = [
            "URL Request description:",
            "🌍🔼 \(method) \(url)",
            "🌍🔼 \(header)",
            "🌍🔼 \(body)"
        ]

        print("🌍🔼 \(method) \(url)")
        print(content.joined(separator: "\n"))
    }
}
