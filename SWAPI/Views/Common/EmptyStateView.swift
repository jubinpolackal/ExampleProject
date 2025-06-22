//
//  EmptyStateView.swift
//  SWAPI
//
//  Created by Jubin Jose on 2025-06-22.
//

import SwiftUI

struct EmptyStateView: View {
   var message:String = ""
   var action: () async -> Void
    var body: some View {
       VStack(spacing: 16) {
           Text(message)
           Button("Retry") {
               Task { await action() }
           }
           .buttonStyle(.borderedProminent)
       }
       .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    EmptyStateView(message: "Empty", action: {
       print("Empty")
    })
}
