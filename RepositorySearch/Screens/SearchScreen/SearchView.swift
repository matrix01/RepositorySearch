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
            VStack {
                if viewModel.isLoading {
                    progressView
                        .accessibilityIdentifier("ProgressView")
                }
                if viewModel.searchResults.isEmpty && !viewModel.isLoading {
                    EmptyView(message: "Start typing to see results...")
                        .accessibilityIdentifier("Empty")
                }
                List(viewModel.searchResults, id: \.self) { result in
                    rowItem(repoItem: result)
                }
                .disabled(viewModel.isLoading)
            }
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
            .navigationTitle("Search")
        }
    }
    
    /// View to show view is loading
    @ViewBuilder
    var progressView: some View {
        HStack(alignment: .center, spacing: 10) {
            ProgressView()
            Text(viewModel.isLoading ? "Loading" : "Not Loading")
        }
    }
    
    /// Row View for github repository items
    @ViewBuilder
    func rowItem(repoItem: RepoItem) -> some View {
        NavigationLink {
            detailScreen(repoItem: repoItem)
        } label: {
            Text(repoItem.htmlUrl ?? "")
                .font(.headline)
        }
    }
    
    /// Detail screen builder. on error it shows empty screen
    @ViewBuilder
    private func detailScreen(repoItem: RepoItem) -> some View {
        if let detailViewModel = viewModel.makeViewModel(item: repoItem) {
            DetailView(viewModel: detailViewModel)
        } else {
            EmptyView(message: "Failed to initialize detail view")
        }
    }
}

#if DEBUG
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: SearchViewModel())
    }
}
#endif
