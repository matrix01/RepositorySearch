//
//  SearchViewModel.swift
//  RepositorySearch
//
//  Created by Matrix on 2023/03/04.
//

import Combine
import Foundation

class SearchViewModel: ObservableObject {
    /// Search input for UI search bar binding
    @Published var searchText: String = ""
    
    /// Search result with Repository items. empty for error
    @Published var searchResults: [RepoItem] = []
   
    /// Search api service use case
    private let apiService: RepoSearchAPIUseCase
    
    /// collection of cancellable
    var cancellables = Set<AnyCancellable>()
    
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    /// Init method for search view model
    /// - Parameter apiService: Repo api service
    init(apiService: RepoSearchAPIUseCase = SearchAPIService()) {
        self.apiService = apiService
        
        $searchText
            .debounce(for: .seconds(1), scheduler: RunLoop.main)
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
        Task {
            try? await fetchRepos(query: query)
        }
    }
    
    
    /// Fetch api results from api use cases
    /// - Parameter query: search query from search bar
    @MainActor
    func fetchRepos(query: String) async throws {
        let searchResult = try await apiService.fetchRepoList(for: .search(query: query))
        searchResults = searchResult.items ?? []
    }
}
