//
//  BaseLayer.swift
//  PickupGames
//
//  Created by Andrew Daniels on 10/28/19.
//  Copyright © 2019 Andrew Daniels. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseDatabase
//import FirebaseFirestore

class FirebaseDbLayer<T: FirebaseCodable> {
    
    public var firebaseSingleton = FirebaseSingleton.instance
    public var basePath: Path! = nil
    
    public func getBy(id: String, asyncCompleteWithObject: @escaping (T?, Error?) -> Void) {
        firebaseSingleton.databaseRef.child(basePath.build(with: id)).observeSingleEventAndSingleObject(eventType: .value) { (obj: T?, error, index) in
            asyncCompleteWithObject(obj, error)
        }
    }
    
    public func getAll(asyncCompleteWithObjects: @escaping ([T]?, Error?) -> Void) {
        firebaseSingleton.databaseRef.child(basePath.build()).observeSingleEventAndArrayOfObjects(eventType: .value) { (objs: [T]?, error) in
            asyncCompleteWithObjects(objs, error)
        }
    }
    
    public func getAllBy(ids: [String], asyncCompleteWithObjects: @escaping ([T]) -> Void) {
        var returnValuesDict = [Int: T?]()
        var returnValue = [T]()
        for (index, id) in ids.enumerated() {
            firebaseSingleton.databaseRef.child(basePath.build(with: id)).observeSingleEventAndSingleObject(eventType: .value, forIndex: index) { (obj: T?, error, index) in
                returnValuesDict[index] = obj
                if returnValuesDict.count == ids.count {
                    for i in 0...returnValuesDict.count {
                        if let valueOptional = returnValuesDict[i], let value = valueOptional {
                            returnValue.append(value)
                        }
                    }
                    asyncCompleteWithObjects(returnValue)
                }
            }
        }
    }
    
    public func startQuery() -> DatabaseReference {
        return firebaseSingleton.databaseRef.child(basePath.build())
    }
}
