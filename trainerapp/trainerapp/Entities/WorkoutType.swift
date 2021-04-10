//
//  Workout.swift
//  trainerapp
//
//  Created by Andrew Daniels on 3/5/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import Foundation

struct WorkoutType: SomeCodable {
     
    var id: String!
    var title: String!
    var formType: FormType!
    
    enum FormType {
        case SetRepWeight
        case Distance
    }
    
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
