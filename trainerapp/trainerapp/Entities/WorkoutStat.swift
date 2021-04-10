//
//  WorkoutStat.swift
//  trainerapp
//
//  Created by Andrew Daniels on 3/5/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import Foundation

struct WorkoutStat: SomeCodable {
    
    var id: String!
    var reps: Int!
    var weight: Int?
    var set: Int!
    var time: String?
    var comments: String?
    
    public enum Keys: String, CodingKey {
        case id
    }
    
    
    func encode(to encoder: Encoder) throws {
        _ = encoder.container(keyedBy: Keys.self)
    }
    
    init(from decoder: Decoder) throws {
        _ = try decoder.container(keyedBy: Keys.self)
    }
    
    init() {
        
    }
    
}
