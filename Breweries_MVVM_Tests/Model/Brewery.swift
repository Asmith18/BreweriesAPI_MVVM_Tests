//
//  Brewery.swift
//  Breweries_MVVM_Tests
//
//  Created by adam smith on 2/18/22.
//

import Foundation

struct Brewery: Decodable {
    let results: [BreweryResults]
}

struct BreweryResults: Decodable {
   private enum CodingKeys: String, CodingKey {
        case name
        case city
        case state
        case breweryType = "brewery_type"
        case street
    }
    let name: String
    let city: String
    let state: String
    let breweryType: String
    let street: String
}
