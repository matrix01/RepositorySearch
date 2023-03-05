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
                Text(result.htmlUrl ?? "")
            }
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
            .navigationTitle("Search")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: SearchViewModel())
    }
}
