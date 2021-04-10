//
//  SessionLayer.swift
//  trainerapp
//
//  Created by Andrew Daniels on 3/5/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import Foundation

class SessionLayer: SomeStoreLayer<Session, Session.Keys> {
    
    override init () {
        super.init()
        self.basePath.value = "sessions/{id}"
    }
}
