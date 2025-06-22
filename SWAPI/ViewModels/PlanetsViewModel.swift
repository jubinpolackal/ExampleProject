//
//  PlanetsViewModel.swift
//  SWAPI
//
//  Created by Jubin Jose on 2025-06-13.
//

import Foundation


@MainActor
final class PlanetsViewModel: ObservableObject {
   
   @Published var planets: [Planet] = []
   @Published var errorMessage: String?
   @Published var isLoading: Bool = false
   
   private let webService: WebServiceProtocol
   
   init(webService: WebServiceProtocol) {
      self.webService = webService
   }
   
   func fetchPlanetsAsync() async {
      isLoading = true
      errorMessage = nil
      do {
         planets = try await webService.fetchList(for: Planet.self, endPoint: EndPoints.allPlanets)
      } catch(let error) {
         errorMessage = error.localizedDescription
      }
      isLoading = false
   }
}
