//
//  SearchApiCallTests.swift
//  RepositorySearchTests
//
//  Created by Matrix on 2023/03/04.
//

import XCTest
@testable import RepositorySearch

final class SearchApiCallTests: XCTestCase {

    var sut: SearchAPICall! = nil
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = SearchAPICall.search(query: "")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    /// Test SearchAPICall with static values
    func test_search_api_call_endpoint_success() throws {
        let headers = sut.headers
        let body = try sut.body()
        let host = sut.host
        let path = sut.path
        let method = sut.method
        
        XCTAssertEqual(headers, APIServcie.commonHeaders)
        XCTAssertNil(body)
        XCTAssertEqual(host, "api.github.com")
        XCTAssertEqual(path, "/search/repositories")
        XCTAssertEqual(method, .GET)
    }
    
    /// Test SearchAPICall with values from URLRequest
    func test_search_api_call_request_success() throws {
        // Arrange
        let headers = sut.headers
        let body = try sut.body()
        let host = sut.host
        let path = sut.path
        let method = sut.method
        let request = try sut.urlRequest()
        
        // Assert
        XCTAssertEqual(headers, request.allHTTPHeaderFields)
        XCTAssertEqual(body, request.httpBody)
        XCTAssertNotNil(request.url)
        XCTAssertEqual(request.httpMethod, method.rawValue)
    }
    
    /// Common error description tests
    func test_api_error_description_success() throws {
        // Arrange
        let invalidUrlError = APIError.invalidURL
        let errorWithCode = APIError.httpCode(404)
        let unexpectedResponse = APIError.unexpectedResponse
        let imageDeserialization = APIError.imageDeserialization
        
        // Assert
        XCTAssertEqual(invalidUrlError.errorDescription, "Invalid URL")
        XCTAssertEqual(errorWithCode.errorDescription, "Unexpected HTTP code: 404")
        XCTAssertEqual(unexpectedResponse.errorDescription, "Unexpected response from the server")
        XCTAssertEqual(imageDeserialization.errorDescription, "Cannot deserialize image from Data")
    }
}
