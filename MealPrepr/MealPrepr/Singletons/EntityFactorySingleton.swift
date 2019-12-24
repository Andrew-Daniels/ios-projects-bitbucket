//
//  EntityFactory.swift
//  PickupGames
//
//  Created by Andrew Daniels on 10/25/19.
//  Copyright © 2019 Andrew Daniels. All rights reserved.
//

import Foundation

struct EntityFactorySingleton {
    
    static let instance = EntityFactorySingleton()
    
    public var users: UserLayer!
    
    private init() {
        self.users = UserLayer()
    }
}
