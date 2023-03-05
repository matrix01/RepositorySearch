//
//  SearchView.swift
//  RepositorySearch
//
//  Created by Matrix on 2023/03/04.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.searchResults, id: \.self) { result in
                NavigationLink {
                    detailScreen(repoItem: result)
                } label: {
                    Text(result.htmlUrl ?? "")
                        .font(.headline)
                }
            }
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
            .navigationTitle("Search")
        }
    }
    
    @ViewBuilder
    private func detailScreen(repoItem: RepoItem) -> some View {
        if let detailViewModel = viewModel.makeViewModel(item: repoItem) {
            DetailView(viewModel: detailViewModel)
        } else {
            EmptyView()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: SearchViewModel())
    }
}
