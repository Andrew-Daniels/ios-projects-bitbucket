//
//  Location.swift
//  PickupGames
//
//  Created by Andrew Daniels on 10/25/19.
//  Copyright © 2019 Andrew Daniels. All rights reserved.
//

import Foundation

class Location: Codable {
    var city: String!
    var state: String!
    var zipCode: Int!
    var streetAddress: String!
        
    public enum Keys: String, CodingKey {
            case city
            case state
            case zipCode
            case streetAddress
    }
    
    init() {
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(city, forKey: .city)
        try container.encode(state, forKey: .state)
        try container.encode(zipCode, forKey: .zipCode)
        try container.encode(streetAddress, forKey: .streetAddress)
    }
        
    required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: Keys.self)
            self.city = try container.decodeIfPresent(String.self, forKey: .city)
            self.state = try container.decodeIfPresent(String.self, forKey: .state)
            self.zipCode = try container.decodeIfPresent(Int.self, forKey: .zipCode)
            self.streetAddress = try container.decodeIfPresent(String.self, forKey: .streetAddress)
    }
}
