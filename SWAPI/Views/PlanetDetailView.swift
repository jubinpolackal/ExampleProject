//
//  PlanetDetailView.swift
//  SWAPI
//
//  Created by Jubin Jose on 2025-06-14.
//

import SwiftUI

struct PlanetDetailView: View {
   let planet: Planet
    var body: some View {
       List {
          TwoTextCellView(leftText: "Terrain", rightText: planet.terrain)
          TwoTextCellView(leftText: "Population", rightText: planet.population)
       }.padding(16)
          .navigationTitle(planet.name)
    }
}

#Preview {
    //PlanetDetailView()
}
