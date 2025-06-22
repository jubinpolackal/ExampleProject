//
//  PeopleListView.swift
//  SWAPI
//
//  Created by Jubin Jose on 2025-06-13.
//

import SwiftUI

struct PeopleListView: View {
   @StateObject var viewModel = PeopleViewModel(webService: SWAPIWebService())
   @State private var searchText: String = ""
   var body: some View {
      NavigationStack {
         Group {
            if viewModel.isLoading {
               ProgressView("Loading People...")
            } else if let errorMessage = viewModel.errorMessage {
               ErrorView(message: errorMessage, action: viewModel.fetchPeopleAsync)
            } else if viewModel.people.isEmpty {
               EmptyStateView(message: "People not found", action: viewModel.fetchPeopleAsync )
            } else {
               peopleList
            }
         }
         .navigationTitle(Text("People"))
         .task {
            await viewModel.fetchPeopleAsync()
         }.navigationDestination(for: Person.self) { person in
            PersonDetailView(person: person)
         }
      }
   }
   
   // MARK: - Subviews
   
   private var peopleList: some View {
       List {
           ForEach(viewModel.people.filter {
               searchText.isEmpty || $0.name.lowercased().contains(searchText.lowercased())
           }) { person in
               NavigationLink(value: person) {
                   TwoTextCellView(leftText: person.name, rightText: person.birthYear)
               }
           }
       }
       .refreshable {
           await viewModel.fetchPeopleAsync()
       }
       .searchable(text: $searchText, prompt: "Search People")
   }
}

#Preview {
    PeopleListView()
}
