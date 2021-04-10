//
//  EntityFactorySingleton.swift
//  trainerapp
//
//  Created by Andrew Daniels on 3/2/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import Foundation

struct EntityFactorySingleton {
    
    static let instance = EntityFactorySingleton()
    
    public var athletes: AthleteLayer!
    public var sessions: SessionLayer!
    public var trainers: TrainerLayer!
    
    private init() {
        self.athletes = AthleteLayer()
        self.sessions = SessionLayer()
        self.trainers = TrainerLayer()
    }
}
