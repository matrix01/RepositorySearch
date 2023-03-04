//
//  RepositoryModelTests.swift
//  RepositorySearchTests
//
//  Created by Matrix on 2023/03/04.
//

import XCTest
@testable import RepositorySearch

final class RepositoryModelTests: XCTestCase {
    
    /// Test if all values initialize properly
    func test_owner_model_all_values() {
        // Arrange
        let avatarURL = "https://www.example.com"
        
        // Act
        let owner = RepoOwner(id: 1, avatarUrl: avatarURL)
        
        // Assert
        XCTAssertEqual(owner.id, 1)
        XCTAssertEqual(owner.avatarUrl, avatarURL)
    }
    
    /// Test if nil values are handled
    /// If someone changes by mistake nil or required this will fail
    func test_owner_model_nil_values() {
        let owner = RepoOwner(id: 1, avatarUrl: nil)
        
        XCTAssertEqual(owner.id, 1)
        XCTAssertNil(owner.avatarUrl)
    }
    
    /// Test with all values
    func test_repo_item_model_all_values() {
        // Arrange
        let avatarURL = "https://www.example.com"
        let htmlURL = "https://www.html.com"
        
        // Act
        let owner = RepoOwner(id: 1, avatarUrl: avatarURL)
        let repoItem = RepoItem(id: 1, owner: owner, htmlUrl: htmlURL)
        
        // Assert
        XCTAssertEqual(repoItem.id, 1)
        XCTAssertNotNil(repoItem.owner)
        XCTAssertNotNil(repoItem.htmlUrl)
    }
    
    /// Test nil values
    func test_repo_item_nil_values() {
        let repoItem = RepoItem(id: 1, owner: nil, htmlUrl: nil)
        
        XCTAssertEqual(repoItem.id, 1)
        XCTAssertNil(repoItem.owner)
        XCTAssertNil(repoItem.htmlUrl)
    }
    
    /// Test Owner equatable
    func test_repo_owner_equatable() {
        let owner = RepoOwner(id: 1, avatarUrl: nil)
        let owner1 = RepoOwner(id: 1, avatarUrl: nil)
        let owner2 = RepoOwner(id: 3, avatarUrl: nil)
        
        XCTAssertEqual(owner, owner1)
        XCTAssertNotEqual(owner, owner2)
    }
    
    /// Test RepoItem equatable
    func test_repo_item_equatable() {
        let owner = RepoOwner(id: 1, avatarUrl: nil)
        let owner1 = RepoOwner(id: 1, avatarUrl: nil)
        let owner2 = RepoOwner(id: 3, avatarUrl: nil)
        
        let repoItem = RepoItem(id: 1, owner: owner, htmlUrl: nil)
        let repoItem1 = RepoItem(id: 1, owner: owner1, htmlUrl: nil)
        let repoItem2 = RepoItem(id: 2, owner: owner2, htmlUrl: nil)
        
        XCTAssertEqual(repoItem, repoItem1)
        XCTAssertNotEqual(repoItem, repoItem2)
    }
    
    /// Test RepositoryModel with all values
    func test_repo_model_all_values() {
        // Arrange
        let avatarURL = "https://www.example.com"
        let htmlURL = "https://www.html.com"
        
        // Act
        let owner = RepoOwner(id: 1, avatarUrl: avatarURL)
        let repoItem = RepoItem(id: 1, owner: owner, htmlUrl: htmlURL)
        let repoModel = RepositoryModel(totalCount: 1, isIncomplete: true, items: [repoItem])
        
        // Assert
        XCTAssertEqual(repoModel.totalCount, 1)
        XCTAssertEqual(repoModel.incompleteResults, true)
        XCTAssertEqual(repoModel.items, [repoItem])
    }
    
    /// Test RepositoryModel with empty initialization
    func test_repo_empty_model() {
        let repoModel = RepositoryModel()
        XCTAssertEqual(repoModel.items, [])
        XCTAssertEqual(repoModel.totalCount, 0)
        XCTAssertEqual(repoModel.incompleteResults, false)
    }
    
}
