//
//  TwoTextCellView.swift
//  SWAPI
//
//  Created by Jubin Jose on 2025-06-16.
//

import SwiftUI

struct TwoTextCellView: View {
   let leftText: String
   let rightText: String
    var body: some View {
       HStack {
          Text("\(leftText)")
          Spacer()
          Text("\(rightText)")
       }.padding(16)
    }
}

#Preview {
   TwoTextCellView(leftText: "Label", rightText: "Content")
}
