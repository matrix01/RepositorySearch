//
//  SearchViewModel.swift
//  RepositorySearch
//
//  Created by Matrix on 2023/03/04.
//

import Combine
import Foundation

class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var searchResults: [RepoItem] = []
    private let apiService: RepoSearchAPIUseCase
    
    var cancellables = Set<AnyCancellable>()
    
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
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
    
    func fetch(query: String) {
        if query.isEmpty {
            searchResults = []
            return
        }
        Task.detached { @MainActor in
            do {
                let list = try await self.apiService.fetchRepoList(for: .search(query: query))
                self.searchResults = list.items ?? []
            } catch let error {
                debugPrint(error.localizedDescription)
            }
        }
    }
}
