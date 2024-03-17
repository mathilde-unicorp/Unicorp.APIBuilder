//
//  APIEndpointError.swift
//  
//
//  Created by Ressier Mathilde on 15/03/2024.
//

import Foundation

import Foundation

public enum APIEndpointError: Error {
    case invalidURL(url: String)
    case invalidData

    case requestFailed
    case noResponse
    case noData
    case mimeTypeInvalid
    case conversionFailed(data: Data)
    case statusError(status: HTTPStatusCode)
}
