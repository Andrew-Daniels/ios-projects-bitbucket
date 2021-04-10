//
//  AthleteModel.swift
//  trainerapp
//
//  Created by Andrew Daniels on 3/3/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import Foundation

class AthleteModel {
    
    var id: String!
    var initials: String!
    var firstName: String!
    var middleName: String?
    var lastName: String!
    var fullName: String!
    var age: Int!
    var weight: Double!
    
    public func setup() {
        self.fullName = "\(String(describing: firstName)) \(middleName == nil ? "" : middleName! + " ")\(String(describing: lastName))"
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
