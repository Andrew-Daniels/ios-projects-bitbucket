//
//  PersonLayer.swift
//  PickupGames
//
//  Created by Andrew Daniels on 10/25/19.
//  Copyright © 2019 Andrew Daniels. All rights reserved.
//

import Foundation

class UserLayer: FirebaseStoreLayer<User, User.Keys> {
    
    override init () {
        super.init()
        self.basePath.value = "users/{id}"
    }
}
