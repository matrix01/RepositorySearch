//
//  DetailViewModel.swift
//  RepositorySearch
//
//  Created by Matrix on 2023/03/05.
//

import Combine
import Foundation

class DetailViewModel: ObservableObject {
    private(set) var htmlURL: String
    private(set) var avatarURL: URL
    
    init(htmlURL: String, avatarURL: URL) {
        self.htmlURL = htmlURL
        self.avatarURL = avatarURL
    }
}
