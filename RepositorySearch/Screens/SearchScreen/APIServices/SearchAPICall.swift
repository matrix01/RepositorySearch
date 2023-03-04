//
//  SearchAPICall.swift
//  RepositorySearch
//
//  Created by Matrix on 2023/03/04.
//

import Foundation

struct SearchAPICall: APICall {
    var host: String {
        "api.github.com"
    }
    
    var path: String {
        "/" + "search/repositories"
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
