//
//  Encodable+extensions.swift
//
//
//  Created by Ressier Mathilde on 15/03/2024.
//

import Foundation

extension Encodable {

    public var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (
            try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
        ).flatMap { $0 as? [String: Any] }
    }

    public var stringDictionary: [String: String]? {
        dictionary.flatMap({ $0 as? [String: String] })
    }
}
