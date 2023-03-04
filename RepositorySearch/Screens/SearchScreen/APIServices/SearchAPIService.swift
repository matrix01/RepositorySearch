//
//  SearchApiService.swift
//  RepositorySearch
//
//  Created by Matrix on 2023/03/04.
//

import Foundation

protocol RepoSearchAPIUseCase {
    func fetchRepoList()
}

class SearchAPIService: APIServcie, RepoSearchAPIUseCase {
    func fetchRepoList() {
        
    }
}
