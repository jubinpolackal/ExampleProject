//
//  Person.swift
//  SWAPI
//
//  Created by Jubin Jose on 2025-06-13.
//

import Foundation


struct Person: Identifiable, Codable, Hashable {
   var name: String
   var height: String
   var mass: String
   var hairColor: String
   var skinColor: String
   var eyeColor: String
   var birthYear: String
   var gender: String
   var homeworld: String
   var films: [String]
   var species: [String]
   var vehicles: [String]
   var starships: [String]
   var created: String
   var edited: String
   var url: String
   
   enum CodingKeys: String, CodingKey {
       case name, height, mass, gender, homeworld, films, species, vehicles, starships, created, edited, url
       case hairColor = "hair_color"
       case skinColor = "skin_color"
       case eyeColor = "eye_color"
       case birthYear = "birth_year"
   }

   var id: Int { url.getIdFromUrl()! }
   var homePlanet: Int { homeworld.getIdFromUrl()! }
}
