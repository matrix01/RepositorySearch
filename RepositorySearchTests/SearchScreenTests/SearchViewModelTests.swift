//
//  SearchViewModelTests.swift
//  RepositorySearchTests
//
//  Created by Matrix on 2023/03/05.
//

import Combine
import XCTest
@testable import RepositorySearch

final class SearchViewModelTests: XCTestCase {
    
    func test_search_view_model_fetchRepos_list_success() {
        let session = URLSession(mockResponder: RepositoryModel.MockDataResponder.self)
        let service = SearchAPIService(session: session)
        let sut = SearchViewModel(apiService: service)
        
        sut.fetch(query: "")
        XCTAssertEqual(sut.searchResults.count, 0)
        
        Task {
            try? await sut.fetchRepos(query: "hello")
            XCTAssertEqual(sut.searchResults.count, 30)
        }
    }
    
    func test_search_view_model_fetch_list_success() {
        let session = URLSession(mockResponder: RepositoryModel.MockDataResponder.self)
        let service = SearchAPIService(session: session)
        let sut = SearchViewModel(apiService: service)
        
        sut.fetch(query: "abcd")
        XCTAssertEqual(sut.searchResults.count, 0)
    }
    
    func test_make_detail_model_success() {
        let avatarURL = "https://www.example.com"
        let htmlURL = "https://www.html.com"
        
        let owner = RepoOwner(id: 1, avatarUrl: avatarURL)
        let repoItem = RepoItem(id: 1, owner: owner, htmlUrl: htmlURL)
        
        let session = URLSession(mockResponder: RepositoryModel.MockDataResponder.self)
        let service = SearchAPIService(session: session)
        let sut = SearchViewModel(apiService: service)
        
        let detailModel = sut.makeViewModel(item: repoItem)
        
        XCTAssertNotNil(detailModel)
        XCTAssertEqual(detailModel?.avatarURL, URL(string: avatarURL))
        XCTAssertEqual(detailModel?.htmlURL, htmlURL)
        
    }
}
