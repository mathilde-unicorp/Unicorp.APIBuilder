
//
//  APIEndpoint.swift
//
//  Created by Ressier Mathilde on 26/01/2024.
//

import Foundation

/// A configurable endpoint that can be used to make requests
///
/// Implement your own custom endpoint base like:
/// ```
/// struct RefugesInfoEndpoint: Endpoint {
///     // Default values specific to the API
///     let scheme: String = "https"
///     let host: String = "refuges.info"
///     let defaultPath: String = "/api/"
///
///     // Paths to API endpoints
///     var path: String
///     var queryItems: [URLQueryItem]
///     }
/// ```
public protocol APIEndpoint {
    associatedtype Header: Encodable
    associatedtype Body: Encodable

    var baseURL: String { get }
    var defaultPath: String { get }

    var path: String { get set }
    var queryItems: [URLQueryItem] { get set }

    var headers: Header { get set }
    var contentType: ContentType { get set }
    var body: Body? { get set }
}

// =============================================================================
// MARK: - Requests
// =============================================================================

extension APIEndpoint {

    public func buildURLRequest(requestType: RequestType) throws -> URLRequest {
        guard let url = self.buildURL() else {
            throw APIEndpointError.invalidURL(url: self.path)
        }

        guard let urlRequest = self.buildURLRequest(from: url, requestType: .GET) else {
            throw APIEndpointError.invalidData
        }

        return urlRequest
    }
}

// =============================================================================
// MARK: - Configuration
// =============================================================================

extension APIEndpoint {
    /// Build URL from the API Endpoint
    private func buildURL() -> URL? {
        let mainURL = URL(string: baseURL)?
            .appending(path: defaultPath)
            .appending(path: path)

        guard let url = mainURL?.absoluteString else { return nil }

        var components = URLComponents(string: url)
        components?.queryItems = self.queryItems.isEmpty ? nil : self.queryItems

        // If either the path or the query items passed contained
        // invalid characters, we'll get a nil URL back
        return components?.url
    }

    /// Build the URL Request from the API Endpoint, using a URL and a request Type
    private func buildURLRequest(from url: URL, requestType: RequestType) -> URLRequest? {
        var request = URLRequest(url: url)

        request.set(contentType: contentType)
        request.set(requestType: requestType)
        request.add(headers: headers)

        if let body = body, let httpBody = try? JSONEncoder().encode(body) { //} body?.data(ofType: self.contentType) {
            request.httpBody = httpBody
        }

        return request
    }
}
