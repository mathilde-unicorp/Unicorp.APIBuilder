//
//  APIEndpoint_getTests.swift
//  
//
//  Created by Ressier Mathilde on 15/03/2024.
//

import XCTest
import Unicorp_APIBuilder

final class APIEndpoint_getTests: XCTestCase {

    // Mock API Default Endpoint structures

    struct HttpBinEnpoint: APIEndpoint {
        var baseURL: String = "https://httpbin.org/"
        var defaultPath: String = ""

        var path: String
        var queryItems: [URLQueryItem]

        var headers: [String: String] = [:]
        var contentType: ContentType = .json
        var body: APIEmpty? = nil
    }

    struct GetResponse: Decodable {
        let args: [String: String]
        let headers: [String: String]
        let origin: String
    }

    // -------------------------------------------------------------------------
    // MARK: - Tests
    // -------------------------------------------------------------------------

    func testAPIEndpoint_getRequest() async throws {
        let testValue = "hello, world"
        let testGet = HttpBinEnpoint(path: "get", queryItems: [
            URLQueryItem(name: "test", value: testValue)
        ])

        let urlRequest = try testGet.buildURLRequest(requestType: .GET)

        let result: GetResponse = try await urlRequest.send()

        XCTAssertEqual(result.args, ["test": testValue])
    }

    func testAPIEndpoint_getWithHeadersRequest() async throws {
        let testValue = "hello, world"
        let headers = ["Authorization": "Bearer 1234567890"]
        let testGet = HttpBinEnpoint(
            path: "get",
            queryItems: [URLQueryItem(name: "test", value: testValue)],
            headers: headers
        )

        let urlRequest = try testGet.buildURLRequest(requestType: .GET)

        let result: GetResponse = try await urlRequest.send()

        XCTAssertEqual(result.args, ["test": testValue])
        XCTAssertEqual(result.headers["Authorization"], headers["Authorization"])
    }
}
