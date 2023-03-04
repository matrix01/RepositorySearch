//
//  SearchApiService.swift
//  RepositorySearch
//
//  Created by Matrix on 2023/03/04.
//

import Foundation

protocol RepoSearchAPIUseCase {
    func fetchRepoList(for endPoint: SearchAPICall) async throws -> RepositoryModel
}

class SearchAPIService: APIServcie, RepoSearchAPIUseCase {
    func fetchRepoList(for endPoint: SearchAPICall) async throws -> RepositoryModel {
        try await fetch(endpoint: endPoint)
    }
}
