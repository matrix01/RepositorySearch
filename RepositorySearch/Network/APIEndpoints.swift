//
//  ApiEndpoints.swift
//  RepositorySearch
//
//  Created by Matrix on 2023/03/04.
//

import Foundation


/// HTTP Methods
enum HTTPMethod: String {
    case GET
    case POST
    case PATCH
    case DELETE
}

/// API Endpoints protocol
/// Requirements provider for api requests
protocol APICall {
    
    /// - Parameter host: domain for the api service
    /// Keeping it flex for when the app uses different domains in different module
    var host: String { get }

    /// - Parameter path: path for  a specific api
    var path: String { get }
    
    /// - Parameter method: GET / POST / PATH / DELETE
    var method: HTTPMethod { get }
    
    /// - Parameter headers: Headers for URLRequests
    /// Example: ["Accept": "application/json"]
    var headers: [String: String]? { get }

    /// - Parameter params: Query parameters for api
    var params: [URLQueryItem] { get }
    
    /// URL request body
    func body() throws -> Data?
}

/// Common API errors
enum APIError: Swift.Error {
    case invalidURL
    case httpCode(HTTPCode)
    case unexpectedResponse
    case imageDeserialization
}

/// Error description Provider
extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case let .httpCode(code): return "Unexpected HTTP code: \(code)"
        case .unexpectedResponse: return "Unexpected response from the server"
        case .imageDeserialization: return "Cannot deserialize image from Data"
        }
    }
}


extension APICall {
    /// Generated URL from the service requirements
    private var fullURL: URL? {
        var urlComponents = URLComponents()
        urlComponents.host = host
        urlComponents.scheme = scheme
        urlComponents.path = path
        urlComponents.queryItems = params
        return urlComponents.url
    }
    
    /// Scheme
    private var scheme: String {
        "https"
    }
    
    /// URLSession requires a request. This create request for given inputs
    /// - Parameter baseURL: Domain or base path of the API service
    /// - Returns: URLRequest
    func urlRequest() throws -> URLRequest {
        guard let url = fullURL else {
            throw APIError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = try body()
        return request
    }
}

typealias HTTPCode = Int
typealias HTTPCodes = Range<HTTPCode>

extension HTTPCodes {
    static let success = 200 ..< 300
}
