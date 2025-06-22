//
//  Confiburation.swift
//  SWAPI
//
//  Created by Jubin Jose on 2025-06-13.
//

// Place for rest of app network configuration

import Foundation

enum EndPoints {
   case allPeople
   case allPlanets
   case allStarships
   case people(Int)
   case planet(Int)
   
   var path: String {
      switch self {
      case .allPeople:
         return "people"
      case .allPlanets:
         return "planets"
      case .allStarships:
         return "starships"
      case .people(let personId):
         return "people/\(personId)"
      case .planet(let planetId):
         return "planets/\(planetId)"
      }
   }
}
