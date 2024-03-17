//
//  File.swift
//  
//
//  Created by Ressier Mathilde on 15/03/2024.
//

import Foundation

extension URLResponse {

    /// Interepret
    var error: APIEndpointError? {
        guard let httpResponse = self as? HTTPURLResponse,
              let responseStatus = httpResponse.status else {
            return .requestFailed
        }

        if responseStatus.responseType == .serverError
            || responseStatus.responseType == .clientError {
            return .statusError(status: responseStatus)
        }

        return nil
    }

}
