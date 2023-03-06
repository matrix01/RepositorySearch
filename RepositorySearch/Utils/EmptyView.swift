//
//  EmptyView.swift
//  RepositorySearch
//
//  Created by Matrix on 2023/03/05.
//

import SwiftUI

/// A view to show appropriate messgage when there's an error or empty screen
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

#if DEBUG
struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView(message: "Nothing to show")
    }
}
#endif
