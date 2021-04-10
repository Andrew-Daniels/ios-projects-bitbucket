//
//  Session.swift
//  trainerapp
//
//  Created by Andrew Daniels on 3/5/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import Foundation

struct Session: SomeCodable {

    var id: String!
    var athletes : [Athlete]!
    var status: SessionStatus!
    var workouts: [WorkoutType]!
    var loggedWorkouts: [SessionWorkout]?
    var scheduledDate: Date!
    var trainers: [Trainer]!
    
    enum SessionStatus {
        case Started
        case Completed
        case NotStarted
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
