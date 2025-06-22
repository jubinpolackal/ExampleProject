//
//  PeopleViewModel.swift
//  SWAPI
//
//  Created by Jubin Jose on 2025-06-13.
//

import Foundation


@MainActor
final class PeopleViewModel: ObservableObject {
   
   @Published var people: [Person] = []
   @Published var errorMessage: String?
   @Published var isLoading = false
   
   private let webService: WebServiceProtocol
   
   init(webService: WebServiceProtocol) {
      self.webService = webService
   }
   
   func fetchPeopleAsync() async {
      isLoading = true
      errorMessage = nil
      do {
         people = try await webService.fetchList(for: Person.self , endPoint: EndPoints.allPeople)
      } catch(let error) {
         errorMessage = error.localizedDescription
      }
      isLoading = false
   }
}
