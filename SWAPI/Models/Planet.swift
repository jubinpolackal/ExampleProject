//
//  Planet.swift
//  SWAPI
//
//  Created by Jubin Jose on 2025-06-13.
//

import Foundation


struct Planet: Codable, Identifiable, Hashable {
   var name: String
   var terrain: String
   var population: String
   var residents: [String]
   var created: String
   var edited: String
   var url: String
   
   var id: Int { url.getIdFromUrl()! }
   var residentIds: [Int] { residents.map{$0.getIdFromUrl()!} }
}
