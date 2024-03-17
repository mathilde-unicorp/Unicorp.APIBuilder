//
//  Data+extensions.swift
//
//
//  Created by Ressier Mathilde on 15/03/2024.
//

import Foundation

extension Data {

    /// Return a readable string of a json data object
    public var jsonPrettyPrintDescription: String? {
        if let object = try? JSONSerialization.jsonObject(with: self, options: []),
           let data2 = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]) {
            let prettyPrintedString = NSString(data: data2, encoding: String.Encoding.utf8.rawValue)
            return String(describing: prettyPrintedString)
        }
        return nil
    }

    /// Decode an object to a `Decodable` object
    public func decode<T: Decodable>(
        decoder: JSONDecoder = JSONDecoder()
    ) throws -> T {
        return try decoder.decode(T.self, from: self)
    }
}
