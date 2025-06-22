//
//  PersonDetailView.swift
//  SWAPI
//
//  Created by Jubin Jose on 2025-06-14.
//

import SwiftUI

struct PersonDetailView: View {
   let person: Person
    var body: some View {
          List {
             TwoTextCellView(leftText: "Height", rightText: person.height)
             TwoTextCellView(leftText: "Mass", rightText: person.mass)
             TwoTextCellView(leftText: "Hair Color", rightText: person.hairColor)
             TwoTextCellView(leftText: "Skin Color", rightText: person.skinColor)
             TwoTextCellView(leftText: "Gender", rightText: person.gender)
            
             //TwoTextCellView(leftText: "Home World", rightText: person.homeworld)
          }.padding(16)
             .navigationTitle(person.name)
       }
}

#Preview {
   let mockPerson: Person = .init(
      name: "Mock Person",
      height: "172 cm",
      mass: "77 kg",
      hairColor: "brown",
      skinColor: "light",
      eyeColor: "blue",
      birthYear: "19BBY",
      gender: "female",
      homeworld: "Tatooine",
      films: ["", ""],
      species: [""],
      vehicles: [""],
      starships: [""],
      created: "",
      edited: "",
      url: ""
   )
   NavigationStack
   {
      PersonDetailView(person: mockPerson)
   }
}
