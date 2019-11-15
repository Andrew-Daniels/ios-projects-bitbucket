//
//  Person.swift
//  PickupGames
//
//  Created by Andrew Daniels on 10/25/19.
//  Copyright © 2019 Andrew Daniels. All rights reserved.
//

import Foundation

class User: FirebaseCodable {
    var id: String!
    var firstName: String!
    var lastName: String!
    var email: String!
    
    init() {
        
    }
    
    public enum Keys: String, CodingKey {
        case firstName
        case lastName
        case email
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
        self.lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
        self.email = try container.decodeIfPresent(String.self, forKey: .email)
    }
}
