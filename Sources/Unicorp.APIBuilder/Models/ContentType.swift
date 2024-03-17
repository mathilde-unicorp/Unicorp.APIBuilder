//
//  ContentType.swift
//  
//
//  Created by Ressier Mathilde on 15/03/2024.
//

import Foundation

/// Content types available for requests
public enum ContentType: Codable {
    case json
    case xwwwFormUrlEncoded
//    case multipartFormData(boundary: String)

    var value: String {
        switch self {
        case .json:
            return "application/json"
        case .xwwwFormUrlEncoded:
            return "application/x-www-form-urlencoded"
//        case .multipartFormData(let boundary):
//            return "multipart/form-data; boundary=\(boundary)"
        }
    }
}
