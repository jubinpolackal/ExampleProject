//
//  SWAPITests.swift
//  SWAPITests
//
//  Created by Jubin Jose on 2025-06-13.
//

import Testing
@testable import SWAPI
import XCTest

let peopleJSONString = """
   [
     {
       "name": "Luke Skywalker",
       "height": "172",
       "mass": "77",
       "hair_color": "blond",
       "skin_color": "fair",
       "eye_color": "blue",
       "birth_year": "19BBY",
       "gender": "male",
       "homeworld": "https://swapi.info/api/planets/1",
       "films": [
         "https://swapi.info/api/films/1",
         "https://swapi.info/api/films/2",
         "https://swapi.info/api/films/3",
         "https://swapi.info/api/films/6"
       ],
       "species": [],
       "vehicles": [
         "https://swapi.info/api/vehicles/14",
         "https://swapi.info/api/vehicles/30"
       ],
       "starships": [
         "https://swapi.info/api/starships/12",
         "https://swapi.info/api/starships/22"
       ],
       "created": "2014-12-09T13:50:51.644000Z",
       "edited": "2014-12-20T21:17:56.891000Z",
       "url": "https://swapi.info/api/people/1"
     },
     {
       "name": "C-3PO",
       "height": "167",
       "mass": "75",
       "hair_color": "n/a",
       "skin_color": "gold",
       "eye_color": "yellow",
       "birth_year": "112BBY",
       "gender": "n/a",
       "homeworld": "https://swapi.info/api/planets/1",
       "films": [
         "https://swapi.info/api/films/1",
         "https://swapi.info/api/films/2",
         "https://swapi.info/api/films/3",
         "https://swapi.info/api/films/4",
         "https://swapi.info/api/films/5",
         "https://swapi.info/api/films/6"
       ],
       "species": [
         "https://swapi.info/api/species/2"
       ],
       "vehicles": [],
       "starships": [],
       "created": "2014-12-10T15:10:51.357000Z",
       "edited": "2014-12-20T21:17:50.309000Z",
       "url": "https://swapi.info/api/people/2"
     }
   ]
   """

let planetJSONString = """
   [
   {
       "name": "Tatooine",
       "rotation_period": "23",
       "orbital_period": "304",
       "diameter": "10465",
       "climate": "arid",
       "gravity": "1 standard",
       "terrain": "desert",
       "surface_water": "1",
       "population": "200000",
       "residents": [
         "https://swapi.info/api/people/1",
         "https://swapi.info/api/people/2",
         "https://swapi.info/api/people/4",
         "https://swapi.info/api/people/6",
         "https://swapi.info/api/people/7",
         "https://swapi.info/api/people/8",
         "https://swapi.info/api/people/9",
         "https://swapi.info/api/people/11",
         "https://swapi.info/api/people/43",
         "https://swapi.info/api/people/62"
       ],
       "films": [
         "https://swapi.info/api/films/1",
         "https://swapi.info/api/films/3",
         "https://swapi.info/api/films/4",
         "https://swapi.info/api/films/5",
         "https://swapi.info/api/films/6"
       ],
       "created": "2014-12-09T13:50:49.641000Z",
       "edited": "2014-12-20T20:58:18.411000Z",
       "url": "https://swapi.info/api/planets/1"
     },
     {
       "name": "Alderaan",
       "rotation_period": "24",
       "orbital_period": "364",
       "diameter": "12500",
       "climate": "temperate",
       "gravity": "1 standard",
       "terrain": "grasslands, mountains",
       "surface_water": "40",
       "population": "2000000000",
       "residents": [
         "https://swapi.info/api/people/5",
         "https://swapi.info/api/people/68",
         "https://swapi.info/api/people/81"
       ],
       "films": [
         "https://swapi.info/api/films/1",
         "https://swapi.info/api/films/6"
       ],
       "created": "2014-12-10T11:35:48.479000Z",
       "edited": "2014-12-20T20:58:18.420000Z",
       "url": "https://swapi.info/api/planets/2"
     }
   ]
   """

class MockWebService: WebServiceProtocol {

   func fetchList<T>(for type: T.Type, endPoint: SWAPI.EndPoints) async throws -> [T] where T : Decodable, T : Encodable {
      switch(type) {
         case is Person.Type:
      return try JSONDecoder().decode( [Person].self, from: Data(peopleJSONString.utf8)) as! [T]
         case is Planet.Type:
      return try JSONDecoder().decode( [Planet].self, from: Data(planetJSONString.utf8)) as! [T]
      default:
         throw WebServiceError.decodingError
      }
   }
}
    
@MainActor
@Test func testLoadPeople() async {
   let mockService = MockWebService()
   let viewModel = PeopleViewModel(webService: mockService)
   await viewModel.fetchPeopleAsync()
   let people = viewModel.people
   #expect(people.count == 2)
   #expect(people[0].name == "Luke Skywalker")
}

@MainActor
@Test func testLoadPlanets() async {
   let mockService = MockWebService()
   let viewModel = PlanetsViewModel(webService: mockService)
   await viewModel.fetchPlanetsAsync()
   let planets = viewModel.planets
   #expect(planets.count == 2)
   #expect(planets[0].name == "Tatooine")
}
