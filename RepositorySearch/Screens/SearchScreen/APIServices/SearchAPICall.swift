//
//  SearchAPICall.swift
//  RepositorySearch
//
//  Created by Matrix on 2023/03/04.
//

import Foundation

enum SearchAPICall: APICall {
    case search
    
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
        []
    }
    
    func body() throws -> Data? {
        nil
    }
}
