//
//  AthleteLayer.swift
//  trainerapp
//
//  Created by Andrew Daniels on 3/2/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import Foundation

class AthleteLayer: SomeStoreLayer<Athlete, Athlete.Keys> {
    
    override init () {
        super.init()
        self.basePath.value = "athletes/{id}"
    }
}
