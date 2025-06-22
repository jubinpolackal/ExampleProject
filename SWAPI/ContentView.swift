//
//  ContentView.swift
//  SWAPI
//
//  Created by Jubin Jose on 2025-06-13.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
       TabView {
          PeopleListView()
          .tabItem {
             Label("People", systemImage: "person.crop.circle")
          }
          
         PlanetsListView()
          .tabItem {
             Label("Planets", systemImage: "globe")
          }
       }
    }
}

#Preview {
    ContentView()
}
