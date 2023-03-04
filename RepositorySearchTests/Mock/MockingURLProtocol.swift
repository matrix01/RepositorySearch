//
//  MockURLSession.swift
//  RepositorySearchTests
//
//  Created by Matrix on 2023/03/04.
//

import Foundation
import XCTest
@testable import RepositorySearch

protocol MockURLResponder {
    static func respond(to request: URLRequest) throws -> (Data, HTTPURLResponse?)
}

class MockURLProtocol<Responder: MockURLResponder>: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
        guard let client = client else { return }
        
        do {
            // Here we try to get data from our responder type, and
            // we then send that data, as well as a HTTP response,
            // to our client. If any of those operations fail,
            // we send an error instead:
            let result = try Responder.respond(to: request)
            let response = try XCTUnwrap(result.1)
            client.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client.urlProtocol(self, didLoad: result.0)
        } catch {
            client.urlProtocol(self, didFailWithError: error)
        }
        
        client.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
        // Required method, implement as a no-op.
    }
    
    static func success(for url: URL) -> HTTPURLResponse? {
        HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: "HTTP/1.1",
            headerFields: nil
        )
    }
    
    static func failure(for url: URL) -> HTTPURLResponse? {
        HTTPURLResponse(
            url: url,
            statusCode: 404,
            httpVersion: "HTTP/1.1",
            headerFields: nil
        )
    }
}

extension URLSession {
    convenience init<T: MockURLResponder>(mockResponder: T.Type) {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol<T>.self]
        self.init(configuration: config)
        URLProtocol.registerClass(MockURLProtocol<T>.self)
    }
}

func loadJson(fileName: String) -> Data? {
   guard
    let url = Bundle(for: RepositoryModelTests.self).url(forResource: fileName, withExtension: "json"),
    let data = try? Data(contentsOf: url)
   else {
       return nil
   }
   return data
}
