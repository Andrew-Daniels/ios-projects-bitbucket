//
//  TrainerLayer.swift
//  trainerapp
//
//  Created by Andrew Daniels on 4/9/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import Foundation

class TrainerLayer: SomeStoreLayer<Trainer, Trainer.Keys> {
    
    override init () {
        super.init()
        self.basePath.value = "trainers/{id}"
    }
}
