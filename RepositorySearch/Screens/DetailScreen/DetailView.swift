//
//  DetailView.swift
//  RepositorySearch
//
//  Created by Matrix on 2023/03/05.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var viewModel: DetailViewModel
    
    var body: some View {
        VStack {
            itemView
                .padding()
            Spacer()
        }
        .navigationTitle("Detail")
    }
    
    @ViewBuilder
    private var itemView: some View {
        HStack {
            image
            leftAlignText
        }
    }
    
    @ViewBuilder
    private var leftAlignText: some View {
        HStack {
            Text(viewModel.htmlURL)
                .font(.body)
                .padding()
            Spacer()
        }
    }
    
    @ViewBuilder
    private var image: some View {
        AsyncImage(
            url: viewModel.avatarURL,
            content: { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 100, maxHeight: 100)
            },
            placeholder: {
                ProgressView()
            }
        )
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(viewModel: DetailViewModel(htmlURL: "", avatarURL: URL(string: "")!))
    }
}
