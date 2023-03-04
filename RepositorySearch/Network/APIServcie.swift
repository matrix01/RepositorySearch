//
//  ApiService.swift
//  RepositorySearch
//
//  Created by Matrix on 2023/03/04.
//

import Foundation

class APIServcie {
    /// default session for api service
    private let session: URLSession
    
    /// Default decoder for JSONDecoder
    static let decoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }()
    
    static var commonHeaders: [String: String]? {
        ["Content-Type": "application/json; charset=utf-8",
         "User-Agent": ""]
    }
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

extension APIServcie {
    /// Base api response fetcher and decoder
    /// - Parameters:
    ///   - endpoint: APICall endpoints
    ///   - decoder: accept JSONDecoder, otherwise uses the default one
    /// - Returns: mapped codable items or throws APIError
    private func fetch<T: Decodable>(endpoint: APICall, decoder: JSONDecoder = APIServcie.decoder) async throws -> T {
        let request = try endpoint.urlRequest()
        let (data, response) = try await URLSession.shared.data(for: request)
        return try parse(data: data, response: response)
    }
    
    
    /// parse data from URLSession request response. Helper method for fetch
    /// - Parameters:
    ///   - data: Data
    ///   - response: URLResponse
    /// - Returns: mapped codable items or throws APIError
    private func parse<T: Decodable>(data: Data, response: URLResponse) throws -> T {
        guard let code = (response as? HTTPURLResponse)?.statusCode else {
            throw APIError.unexpectedResponse
        }
        guard HTTPCodes.success.contains(code) else {
            throw APIError.httpCode(code)
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
}
