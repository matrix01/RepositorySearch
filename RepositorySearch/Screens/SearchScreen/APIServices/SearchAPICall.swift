//
//  SearchAPICall.swift
//  RepositorySearch
//
//  Created by Matrix on 2023/03/04.
//

import Foundation

enum SearchAPICall: APICall {
    case search(query: String)
    
    var host: String {
        "api.github.com"
    }
    
    var path: String {
        switch self {
        case .search: return "/" + "search/repositories"
        }
    }
    
    var method: HTTPMethod {
        .GET
    }
    
    var headers: [String : String]? {
        APIServcie.commonHeaders
    }
    
    var params: [URLQueryItem] {
        switch self {
        case .search(let query):
            return [URLQueryItem(name: "q", value: query)]
        }
    }
    
    func body() throws -> Data? {
        nil
    }
}
