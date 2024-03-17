//
//  URL+extensions.swift
//
//
//  Created by Ressier Mathilde on 15/03/2024.
//

import Foundation

extension URL {

    /// Retrieve data from the current URL with a GET request using the `session` URLSession
    public func getData(session: URLSession = .shared) async throws -> Data {
        let (data, _) = try await session.data(from: self)
        return data
    }

    /// Retrieve data from the current URL with a GET request using the `session` URLSession
    /// and decode the data with the `decoder` provided
    public func get<T: Decodable>(
        session: URLSession = .shared,
        decoder: JSONDecoder = JSONDecoder()
    ) async throws -> T {
        return try await self
            .getData(session: session)
            .decode(decoder: decoder)
    }
}
