//
//  PlanetsListView.swift
//  SWAPI
//
//  Created by Jubin Jose on 2025-06-13.
//

import SwiftUI

struct PlanetsListView: View {
   @StateObject var viewModel = PlanetsViewModel(webService: SWAPIWebService())
   @State private var searchText: String = ""
    var body: some View {
       NavigationStack {
          Group {
             if viewModel.isLoading {
                ProgressView("Loading Planets...")
             } else if let errorMessage = viewModel.errorMessage {
                ErrorView(message: errorMessage, action: viewModel.fetchPlanetsAsync )
             } else if viewModel.planets.isEmpty {
                EmptyStateView(message: "No Planets Found", action: viewModel.fetchPlanetsAsync)
             } else {
                planetList
               }
             }.navigationTitle("Planets")
             .task {
                await viewModel.fetchPlanetsAsync()
             }
             .navigationDestination(for: Planet.self) { planet in
                PlanetDetailView(planet: planet)
             }
          }
       }
   
   // MARK: - Subviews
   
   private var planetList: some View {
       List {
           ForEach(viewModel.planets.filter {
               searchText.isEmpty || $0.name.lowercased().contains(searchText.lowercased())
           }) { planet in
               NavigationLink(value: planet) {
                   TwoTextCellView(leftText: planet.name, rightText: planet.population)
               }
           }
       }
       .refreshable {
           await viewModel.fetchPlanetsAsync()
       }
       .searchable(text: $searchText, prompt: "Search People")
   }
}

#Preview {
   PlanetsListView()
}
