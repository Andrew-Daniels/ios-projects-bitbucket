//
//  PickupGameLayer.swift
//  PickupGames
//
//  Created by Andrew Daniels on 10/25/19.
//  Copyright © 2019 Andrew Daniels. All rights reserved.
//

import Foundation

class PickupGameLayer: FirebaseStoreLayer<PickupGame, PickupGame.Keys> {
    typealias FirebaseCodable = PickupGame
    typealias KeysEnum = PickupGame.Keys
    
    override init () {
        super.init()
        self.basePath.value = "pickupGames/{id}"
    }
    
    func subscribers(forPickupGame: PickupGame) -> FirebaseStoreLayer<PickupGameSubscriber, PickupGameSubscriber.Keys> {
        return self.getChildLayer(forObj: forPickupGame, forKey: .subscribers)
    }
}
