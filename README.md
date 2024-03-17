# Unicorp.APIBuilder
A library to help you build your requests to REST APIs

# Install

Install Unicorp.APIBuilder package using `SPM`:

On the package builder, import the following github link
```
https://github.com/mathilde-unicorp/Unicorp.APIBuilder
```

# Usage

## Build your API Basics

1. Create your APIDefaultEndpoint

This is an example using the refuges.info api

```swift
import Unicorp_APIBuilder

struct RefugesInfoEndpoint: APIEndpoint {
    var baseURL: String = "https://refuges.info"
    let defaultPath: String = "/api/"

    /// Default value for most requests content type
    var contentType: ContentType = .json

    /// Default headers structure 
    var headers: RefugesInfoHeader = [:]
    
    /// Default body to fill
    var body: [String: String]?
    
    // MARK: - Always update informations
    
    /// API endpoint path
    var path: String
    /// Query items to add to the request (`?param=value&...`)
    var queryItems: [URLQueryItem]
    
}

/// Common headers that you can turn into a structure
typealias RefugesInfoHeader = [String: String]
```

2. Call your endpoint

Here is an example of a method making a API Endpoint call

```swift
    func loadRefuge(id: Int) async throws -> RefugesInfo.RefugesPointResponse {
        print("Load refuge id: \(id)")
        
        // Build your API Endpoint
        // On this init, you also can sepcify `headers` and `body` content
        let endpoint = RefugesInfoEndpoint(
            path: "point", // The url path to add to your baseUrl to reach data
            queryItems: [ // query items (`?param=value&...`) to add to the URL
                URLQueryItem(name: "id", value: id.toString),
                URLQueryItem(name: "format", value: "geojson"),
                URLQueryItem(name: "detail", value: "complet")
            ]
        )

        // Turn it into a URLRequest and launch it
        let response: RefugesInfo.RefugesPointResponse = try await endpoint
            .buildURLRequest(requestType: .GET) // Specify your request type here (GET, POST, PATCH , PUT, ...)
            .send(session: .shared) // Launch the API request (async request)

        return response
    }
```

3. Build your API architecture

This is optionnal but I strongly recommend to capture all your requests to your API
into one place. 

```swift

final class RefugesInfoDataProvider {

    private let session: URLSession

    // -------------------------------------------------------------------------
    // MARK: - Init
    // -------------------------------------------------------------------------

    init() {
        // Configure the URL Session you'll using through all your requests
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 60
        self.session = URLSession(configuration: configuration)
    }
}


extension RefugesInfoDataProvider: RefugesInfoDataProviderProtocol {

    // -------------------------------------------------------------------------
    // MARK: - Refuges
    // -------------------------------------------------------------------------

    func loadRefuge(id: Int) async throws -> RefugesInfo.RefugesPointResponse {
        // ... same from previous step
    }

    // Add others requests
}

```
