//
//  RepositoryModel.swift
//  RepositorySearch
//
//  Created by Matrix on 2023/03/04.
//

import Foundation

// MARK: - Repository
// For this demo we are considering that repo item id will be unique so comparing only ids
struct RepositoryModel: Codable {
    let totalCount: Int?
    let incompleteResults: Bool?
    let items: [RepoItem]?
    
    init(totalCount: Int? = 0, isIncomplete: Bool? = false, items: [RepoItem]? = []) {
        self.totalCount = totalCount
        self.incompleteResults = isIncomplete
        self.items = items
    }
}

// MARK: - Item
struct RepoItem: Codable, Identifiable {
    let id: Int
    let owner: RepoOwner?
    let htmlURL: String?
}

extension RepoItem: Hashable {
    static func == (lhs: RepoItem, rhs: RepoItem) -> Bool {
        return lhs.id == rhs.id && lhs.owner?.id == rhs.owner?.id
    }
}

// MARK: - Owner
struct RepoOwner: Codable {
    let id: Int
    let avatarURL: String?
}

extension RepoOwner: Hashable {
    static func == (lhs: RepoOwner, rhs: RepoOwner) -> Bool {
        return lhs.id == rhs.id
    }
}
