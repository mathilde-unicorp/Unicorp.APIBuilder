//
//  File.swift
//  
//
//  Created by Ressier Mathilde on 17/03/2024.
//

import Foundation

/// XWWWFormUrlEncoder
/// As JSonEncoder(), it's used to encode structures conforming to encodable to Data type, using the
/// x-www-form-urlencoded format.
public class XWWWFormUrlEncoder {

    enum EncodingError: Error {
        case invalidValue
    }

    /// Convert an encodable data to the x-www-form-urlencoded format.
    func encode(_ data: Encodable) throws -> Data {
        var mockUrl = URLComponents(string: "")
        mockUrl?.queryItems = data.dictionary?.queryItems

        guard let encoded = mockUrl?.percentEncodedQuery?.data(using: .utf8) else {
            throw EncodingError.invalidValue
        }
        return encoded
    }

}
