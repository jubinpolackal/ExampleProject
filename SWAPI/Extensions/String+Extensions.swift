//
//  String+Extensions.swift
//  SWAPI
//
//  Created by Jubin Jose on 2025-06-13.
//

import Foundation

public extension String {
   var isNotEmpty: Bool {
       !self.isEmpty
   }
   
   var numericPart: Double {
       Double(self.trimmingCharacters(in: CharacterSet.letters)) ?? Double.greatestFiniteMagnitude
   }
   
   func getIdFromUrl() -> Int? {
      let urlString = self
      if let lastComponent = urlString.split(separator: "/").last,
         let id = Int(lastComponent)
      {
         return id
      }
      return nil
   }
}

extension Optional where Wrapped == String {
    func mapToIdentifiable() -> IdentifiableString? {
        self.map { IdentifiableString(value: $0) }
    }
}

struct IdentifiableString: Identifiable {
    let id = UUID()
    let value: String
}
