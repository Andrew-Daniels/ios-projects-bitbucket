//
//  PickupGameSubscriberLayer.swift
//  PickupGames
//
//  Created by Andrew Daniels on 11/10/19.
//  Copyright © 2019 Andrew Daniels. All rights reserved.
//

import Foundation

class PickupGameSubscriberLayer: FirebaseStoreLayer<PickupGameSubscriber> {
    
    init(pickupGameLayerBasePath: String) {
        super.init()
        self.basePath = "\(pickupGameLayerBasePath)/\(PickupGame.Keys.subscribers.rawValue)/{id}"
    }
    
}
