//
//  PickupGame.swift
//  PickupGames
//
//  Created by Andrew Daniels on 10/25/19.
//  Copyright © 2019 Andrew Daniels. All rights reserved.
//

import Foundation
import Firebase

class PickupGame: FirebaseCodable {
    
    var id: String!
    var numberOfAttendees: Int!
    var numberOfSubscribers: Int!
    var title: String!
    var occursAtDate: Date!
    var reoccurring: Bool!
    var subscribers : [PickupGameSubscriber]!
    var location: Location!
    var sports: [String]!
    
    public enum Keys: String, CodingKey {
        case id
        case numberOfAttendees
        case numberOfSubscribers
        case subscriberPartials
        case subscribers //= "pickupGameSubscribers"
        case title
        case location
        case occursAtDate
        case reoccurring
        case sports
    }
    
    init() {
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encodeIfPresent(numberOfAttendees, forKey: .numberOfAttendees)
        try container.encodeIfPresent(numberOfSubscribers, forKey: .numberOfSubscribers)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(occursAtDate, forKey: .occursAtDate)
        try container.encodeIfPresent(reoccurring, forKey: .reoccurring)
        try container.encodeIfPresent(location, forKey: .location)
        try container.encodeIfPresent(sports, forKey: .sports)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.numberOfAttendees = try container.decodeIfPresent(Int.self, forKey: .numberOfAttendees)
        self.numberOfSubscribers = try container.decodeIfPresent(Int.self, forKey: .numberOfSubscribers)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.location = try container.decodeIfPresent(Location.self, forKey: .location)
        let firebaseDate = try container.decodeIfPresent(Double.self, forKey: .occursAtDate)
        self.occursAtDate = firebaseDate?.dateFromFirebaseDouble()
        self.reoccurring = try container.decodeIfPresent(Bool.self, forKey: .reoccurring)
        self.sports = try container.decodeIfPresent([String].self, forKey: .sports)
    }
}
