//
//  ErrorView.swift
//  SWAPI
//
//  Created by Jubin Jose on 2025-06-22.
//

import SwiftUI

struct ErrorView: View {
   var message:String = ""
   var action: () async -> Void
    var body: some View {
       VStack(spacing: 16) {
           Text("Error: \(message)")
           Button("Retry") {
               Task { await action() }
           }
           .buttonStyle(.borderedProminent)
       }
       .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ErrorView(message: "Error occured", action: {
       print("Retrying ...")
    })
}
