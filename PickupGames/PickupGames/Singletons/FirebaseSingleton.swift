//
//  FirebaseSingleton.swift
//  PickupGames
//
//  Created by Andrew Daniels on 9/23/19.
//  Copyright © 2019 Andrew Daniels. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseDatabase
import FirebaseFirestore

class FirebaseSingleton {
    
    static let instance = FirebaseSingleton()
    
    public var storage: Storage!
    public var databaseRef: DatabaseReference!
    public var storageRef: StorageReference!
    public var firestore: Firestore!
    
    private init() {
        self.firestore = Firestore.firestore()
        self.databaseRef = Database.database().reference()
        self.storageRef = Storage.storage().reference()
        self.storage = Storage.storage()
    }
    
}
