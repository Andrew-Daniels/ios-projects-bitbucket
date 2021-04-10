//
//  Trainer.swift
//  trainerapp
//
//  Created by Andrew Daniels on 3/5/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import Foundation

struct Trainer: Person, SomeCodable {
    
    var firstName: String!
    var middleName: String?
    var lastName: String!
    var initials: String!
    var id: String!
    
    
    public enum Keys: String, CodingKey {
        case id
    }
    
    init() {
        
    }
    
    func encode(to encoder: Encoder) throws {
        _ = encoder.container(keyedBy: Keys.self)
    }
    
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: Keys.self)
    }
    
}
