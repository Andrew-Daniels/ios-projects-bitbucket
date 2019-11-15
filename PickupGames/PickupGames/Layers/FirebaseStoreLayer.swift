//
//  FirebaseStoreLayer.swift
//  PickupGames
//
//  Created by Andrew Daniels on 11/4/19.
//  Copyright © 2019 Andrew Daniels. All rights reserved.
//

import Foundation
import Firebase

class FirebaseStoreLayer<T: FirebaseCodable> {
    
    private var firebaseSingleton = FirebaseSingleton.instance
    private var firebaseStorageLayer: FirebaseStorageLayer<T, FirebaseStoreLayer<T>>!
    public var basePath: String! = nil

    init() {
    }
    
    func storage(obj: T) -> FirebaseStorageLayer<T, FirebaseStoreLayer<T>>? {
        return obj.id != nil ? FirebaseStorageLayer(obj: obj, layer: self) : nil
    }
    
    /// Starts the query on the collection
    func startQuery() -> Query {
        return firebaseSingleton.firestore.collection(basePath.pathBuilder())
    }
    
    /// Inserts an object or updates an existing object
    /// - Parameter object: The object to be inserted or updated
    func insertOrUpdate(object: T) -> Bool {
        if let id = object.id {
            return firebaseSingleton.firestore.collection(basePath.pathBuilder()).document(id).setValue(value: object)
        }
        return firebaseSingleton.firestore.collection(basePath.pathBuilder()).document().setValue(value: object)
    }
    
    /// Gets the object by it's id.
    /// - Parameters:
    ///   - id: The identification number of the object
    ///   - asyncCompleteWithObject: Returns the object or nil if it doesn't exist
    func getBy(id: String, asyncCompleteWithObject: @escaping (Result<T, Error>) -> Void) {
        firebaseSingleton.firestore.document(basePath.pathBuilder(replacementStrings: id)).getDocument { (result) in
            asyncCompleteWithObject(result)
        }
    }
    
    /// Gets all documents within a collection
    /// - Parameter asyncCompleteWithObjects: Contains the objects or error if objects could not be found
    func getAll(asyncCompleteWithObjects: @escaping (Result<[T], Error>) -> Void) {
        firebaseSingleton.firestore.collection(basePath.pathBuilder()).getDocuments { (result: Result<[T], Error>) in
            asyncCompleteWithObjects(result)
        }
    }
    
    /// Gets all objects that match the id's supplied
    /// - Parameters:
    ///   - ids: id's of the objects to be retrieved
    ///   - asyncCompleteWithObjects: Contains the objects or error if objects could not be found
    func getAllBy(ids: [String], asyncCompleteWithObjects: @escaping ([Result<T, Error>]) -> Void) {
        var returnValuesDict = [Int: Result<T, Error>]()
        var returnValue = [Result<T, Error>]()
        for (index, id) in ids.enumerated() {
            firebaseSingleton.firestore.document(basePath.pathBuilder(replacementStrings: id)).getDocument(forIndex: index) { (result: Result<T, Error>, index) in
                returnValuesDict[index] = result
                if returnValuesDict.count == ids.count {
                    for i in 0...returnValuesDict.count {
                        if let value = returnValuesDict[i] {
                            returnValue.append(value)
                        }
                    }
                    asyncCompleteWithObjects(returnValue)
                }
            }
        }
    }
    
    /// Get the object by it's id, with index tracking
    /// - Parameters:
    ///   - id: id of the object to be retrieved
    ///   - forIndex: the index of the object in a list of objects that are being retrieved
    ///   - asyncCompleteWithObject: Contains the object or error if the object could not be found
    func getBy(id: String, forIndex: Int, asyncCompleteWithObject: @escaping (Result<T, Error>, Int) -> Void) {
        self.getBy(id: basePath.pathBuilder(replacementStrings: id)) { (result) in
            asyncCompleteWithObject(result, forIndex)
        }
    }
    
    /// Search within a whole collection of groups
    /// - Parameter key: the key of the collection group querying through
    func collectionGroup(key: CodingKey) -> Query {
        return firebaseSingleton.firestore.collectionGroup(key.stringValue)
    }
}
