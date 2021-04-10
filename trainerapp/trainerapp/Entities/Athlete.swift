//
//  Athlete.swift
//  trainerapp
//
//  Created by Andrew Daniels on 3/2/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import Foundation

struct Athlete: Person, SomeCodable {
    
    static func == (lhs: Athlete, rhs: Athlete) -> Bool {
        return lhs.id == rhs.id
    }
    
    var age: Int?
    var weight: Double?
    var firstName: String!
    var middleName: String?
    var lastName: String!
    var initials: String!
    var id: String!
    
    public enum Keys: String, CodingKey {
        case firstName
        case middleName
        case lastName
        case age
        case weight
    }
    
    init() {
        
    }
    
    init(firstName: String, lastName: String) {
        self.id = firstName + lastName
        self.firstName = firstName
        self.lastName = lastName
        self.setup()
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encodeIfPresent(firstName, forKey: .firstName)
        try container.encodeIfPresent(middleName, forKey: .middleName)
        try container.encodeIfPresent(lastName, forKey: .lastName)
        try container.encodeIfPresent(age, forKey: .age)
        try container.encodeIfPresent(weight, forKey: .weight)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
        self.middleName = try container.decodeIfPresent(String.self, forKey: .middleName)
        self.lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
        self.age = try container.decodeIfPresent(Int.self, forKey: .age)
        self.weight = try container.decodeIfPresent(Double.self, forKey: .weight)
    }
    
    func map() -> AthleteModel {
        let returnValue = AthleteModel()
        returnValue.firstName = firstName
        returnValue.middleName = middleName
        returnValue.lastName = lastName
        returnValue.age = age
        returnValue.weight = weight
        returnValue.setup()
        return returnValue
    }
    
    private mutating func setup() {
        let fullName = "\(firstName!) \(middleName == nil ? "" : middleName! + " ")\(lastName!)"
        let names = fullName.split(separator: " ", maxSplits: 2, omittingEmptySubsequences: true)
        if names.count == 3 {
            if let first = names[0].first, let last = names[2].first {
                self.initials = "\(first)\(last)"
            }
        } else if names.count == 2 {
            if let first = names[0].first, let last = names[1].first {
                self.initials = "\(first)\(last)"
            }
        } else if names.count == 1 {
            if let first = names[0].first {
                self.initials = "\(first)"
            }
        }
    }
}
