//
//  SearchApiServiceTests.swift
//  RepositorySearchTests
//
//  Created by Matrix on 2023/03/04.
//

import XCTest
@testable import RepositorySearch

final class SearchApiServiceTests: XCTestCase {

    var sut: SearchAPIService! = nil

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_fetch_repo_list_success() async {
        let session = URLSession(mockResponder: RepositoryModel.MockDataResponder.self)
        sut = SearchAPIService(session: session)
        do {
            let results = try await sut.fetchRepoList(for: .search(query: ""))
            XCTAssertEqual(results.totalCount, 41573)
            XCTAssertEqual(results.incompleteResults, false)
            XCTAssertEqual(results.items?.count, 30)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_fetch_repo_list_error() async {
        let session = URLSession(mockResponder: RepositoryModel.MockFailDataResponder.self)
        sut = SearchAPIService(session: session)
        do {
            let _ = try await sut.fetchRepoList(for: .search(query: ""))
            XCTFail("test_fetch_repo_list_error should return error")
        } catch {
            let errorMessage = (error as? APIError)?.errorDescription
            XCTAssertEqual(errorMessage, "Unexpected HTTP code: 404")
        }
    }
}

extension RepositoryModel {
    enum MockDataResponder: MockURLResponder {
        static func respond(to request: URLRequest) throws -> (Data, HTTPURLResponse?) {
            guard let url = request.url else {
                throw APIError.invalidURL
            }
            
            guard let repoData = loadJson(fileName: "repository") else {
                throw APIError.unexpectedResponse
            }
            let response = MockURLProtocol<MockDataResponder>.success(for: url)
            return (repoData, response)
        }
    }
    
    enum MockFailDataResponder: MockURLResponder {
        static func respond(to request: URLRequest) throws -> (Data, HTTPURLResponse?) {
            guard let url = request.url else {
                throw APIError.invalidURL
            }
            
            guard let repoData = loadJson(fileName: "repository") else {
                throw APIError.unexpectedResponse
            }
            let response = MockURLProtocol<MockDataResponder>.failure(for: url)
            return (repoData, response)
        }
    }
}
