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
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
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
    
    /// URLSession requires a request. This create request for given inputs
    /// - Parameter baseURL: Domain or base path of the API service
    /// - Returns: URLRequest
    func urlRequest(baseURL: String) throws -> URLRequest {
        guard let url = URL(string: baseURL + path) else {
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
