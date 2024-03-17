//
//  Dictionary+extensions.swift
//
//
//  Created by Ressier Mathilde on 17/03/2024.
//

import Foundation

extension Dictionary where Key == String, Value == Any {

    // -------------------------------------------------------------------------
    // MARK: - Conversions
    // -------------------------------------------------------------------------

    /// Convert a dictionary to a query items array that can be used in a url
    public var queryItems: [URLQueryItem] {
        self.map { key, value in
            URLQueryItem(name: key, value: String(describing: value))
        }
    }

    // -------------------------------------------------------------------------
    // MARK: - Additions
    // -------------------------------------------------------------------------

    /// Return a new dictionary with right dictionary and left dictionary content added.
    /// If keys are redundant on right dictionnary, it will override left side keys.
    public static func + (left: [Key: Value], right: [Key: Value]) -> [Key: Value] {
        var result = left

        right.forEach { (key, value) in
            result[key] = value
        }

        return result
    }

    public static func + (left: [Key: Value], right: [Key: Value]?) -> [Key: Value] {
        return left + (right ?? [:])
    }

    public static func + (left: [Key: Value]?, right: [Key: Value]) -> [Key: Value] {
        return (left ?? [:]) + right
    }
}
