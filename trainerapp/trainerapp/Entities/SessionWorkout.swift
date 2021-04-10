//
//  SessionWorkout.swift
//  trainerapp
//
//  Created by Andrew Daniels on 3/5/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import Foundation

enum SessionWorkoutState {
    case editing
    case saved
}

struct SessionWorkout: SomeCodable {
    
    var id: String!
    var athleteId: String!
    var workoutTypeId: String!
    var workoutStats: [WorkoutStat]!
    var state: SessionWorkoutState!
    var completedDate: Date!
    
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
