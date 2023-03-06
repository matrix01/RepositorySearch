//
//  SearchApiService.swift
//  RepositorySearch
//
//  Created by Matrix on 2023/03/04.
//

import Foundation

/// Specific use case for Search screen
protocol RepoSearchAPIUseCase {
    func fetchRepoList(for endPoint: SearchAPICall) async throws -> RepositoryModel
}

/// API service to retrieve data from Server for search screen
class SearchAPIService: APIServcie, RepoSearchAPIUseCase {
    func fetchRepoList(for endPoint: SearchAPICall) async throws -> RepositoryModel {
        return try await fetch(endpoint: endPoint)
    }
}
