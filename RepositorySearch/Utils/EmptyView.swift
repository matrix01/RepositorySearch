//
//  EmptyView.swift
//  RepositorySearch
//
//  Created by Matrix on 2023/03/05.
//

import SwiftUI

struct EmptyView: View {
    var message: String
    
    var body: some View {
        VStack {
            Spacer()
            Text(message)
            Spacer()
        }
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView(message: "Nothing to show")
    }
}
