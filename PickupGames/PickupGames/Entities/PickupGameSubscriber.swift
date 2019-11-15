//
//  PickupGameSubscriber.swift
//  PickupGames
//
//  Created by Andrew Daniels on 11/10/19.
//  Copyright © 2019 Andrew Daniels. All rights reserved.
//

import Foundation

class PickupGameSubscriber: FirebaseCodable {
    var id: String!
    var firstName: String!
    var lastName: String!
    var dateSubscribed: Date!
    
    init(user: User) {
        self.id = user.id
        self.firstName = user.firstName
        self.lastName = user.lastName
        self.dateSubscribed = Date()
    }
    
    public enum Keys: String, CodingKey {
        case firstName
        case lastName
        case id
        case dateSubscribed
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
        self.lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        let firebaseDate = try container.decodeIfPresent(Double.self, forKey: .dateSubscribed)
        self.dateSubscribed = firebaseDate?.dateFromFirebaseDouble()
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encodeIfPresent(firstName, forKey: .firstName)
        try container.encodeIfPresent(lastName, forKey: .lastName)
        try container.encodeIfPresent(dateSubscribed, forKey: .dateSubscribed)
    }
}
