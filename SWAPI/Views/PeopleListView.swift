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
   @State private var sortOption: SortOption = .name
   
   enum SortOption: String, CaseIterable, Identifiable {
      case name = "Name"
      case birthYear = "Birth Year"
      var id: String { rawValue }
   }
   
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
         .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
               Menu {
                  Picker("Sort By", selection: $sortOption) {
                     ForEach(SortOption.allCases, id: \.self) { option in
                        Text(option.rawValue)
                     }
                  }
               } label: {
                  Label("Sort", systemImage: "arrow.up.arrow.down")
               }
            }
         }
         .task {
            await viewModel.fetchPeopleAsync()
         }.navigationDestination(for: Person.self) { person in
            PersonDetailView(person: person)
         }
      }
   }
   
   // MARK: - Subviews
   
   private var peopleList: some View {
      let filteredAndSortedPeople = viewModel.people
         .filter {
            searchText.isEmpty || $0.name.lowercased().contains(searchText.lowercased())
         }
         .sorted(by: { lhs, rhs in
            switch sortOption {
            case .name:
               return lhs.name < rhs.name
            case .birthYear:
               let lhsYear = lhs.birthYear.numericPart
               let rhsYear = rhs.birthYear.numericPart
               return lhsYear < rhsYear
            }
         })
      
       return List {
           ForEach(filteredAndSortedPeople) { person in
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
