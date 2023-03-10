//
//  SearchViewModel.swift
//  RepositorySearch
//
//  Created by Matrix on 2023/03/04.
//

import Combine
import Foundation
import SwiftUI

class SearchViewModel: ObservableObject {
    /// Loading status
    @Published var isLoading: Bool = false
    
    /// Search input for UI search bar binding
    @Published var searchText: String = ""
    
    /// Search result with Repository items. empty for error
    @Published var searchResults: [RepoItem] = []
   
    /// Search api service use case
    private let apiService: RepoSearchAPIUseCase
    
    /// collection of cancellable
    var cancellables = Set<AnyCancellable>()
    
    @State var downloadTask: Task<(), Never>?
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    /// Init method for search view model
    /// - Parameter apiService: Repo api service
    /// Init subscription for searchText which observes the chagnes from navigation search bar
    init(apiService: RepoSearchAPIUseCase = SearchAPIService()) {
        self.apiService = apiService
        
        $searchText
            .debounce(for: .milliseconds(200), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink {[weak self] text in
            
            self?.fetch(query: text)
        }
        .store(in: &cancellables)
    }
    
    /// Fetch method to verify query and comple async task
    /// - Parameter query: search query from search bar
    func fetch(query: String) {
        if query.isEmpty {
            searchResults = []
            return
        }
        downloadTask = Task {
            try? await fetchRepos(query: query)
        }
    }
    
    /// Fetch api results from api use cases
    /// - Parameter query: search query from search bar
    @MainActor
    func fetchRepos(query: String) async throws {
        searchResults = []
        isLoading = true
        
        let searchResult = try await apiService.fetchRepoList(for: .search(query: query))
        searchResults = searchResult.items ?? []
        isLoading = false
    }
    
    /// Cteates the viewmodel for Detail screen and cancel current pending task if there is one
    func makeViewModel(item: RepoItem) -> DetailViewModel? {
        downloadTask?.cancel()
        guard let htmlURL = item.htmlUrl, let avatarURLString = item.owner?.avatarUrl, let avatarURL = URL(string: avatarURLString) else {
            return nil
        }
        return DetailViewModel(htmlURL: htmlURL, avatarURL: avatarURL)
    }
}
