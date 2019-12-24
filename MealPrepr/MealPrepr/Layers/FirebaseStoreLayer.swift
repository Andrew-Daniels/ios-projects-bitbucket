////
////  FirebaseStoreLayer.swift
////  PickupGames
////
////  Created by Andrew Daniels on 11/4/19.
////  Copyright © 2019 Andrew Daniels. All rights reserved.
////
//
//import Foundation
//import Firebase
//
//class FirebaseStoreLayer<T: FirebaseCodable, Keys: CodingKey> {
//    
//    private var firebaseSingleton = FirebaseSingleton.instance
//    public var basePath: Path!
//
//    init() {
//        self.basePath = Path()
//    }
//    
//    convenience init(parentPath: String, forKey: CodingKey) {
//        self.init()
//        self.basePath.value = "\(parentPath)/\(forKey.stringValue)/{id}"
//    }
//    
//    func getChildLayer<ChildType: FirebaseCodable, ChildKeys: CodingKey>(forObj: T, forKey: Keys) -> FirebaseStoreLayer<ChildType, ChildKeys> {
//        return FirebaseStoreLayer<ChildType, ChildKeys>(parentPath: self.basePath.build(with: forObj.id), forKey: forKey)
//    }
//    
//    public func storage(obj: T) -> FirebaseStorageLayer<Keys> {
//        var mutableObj = obj
//        if obj.id == nil {
//            mutableObj.id = firebaseSingleton.firestore.collection(self.basePath.build()).document().documentID
//        }
//        return FirebaseStorageLayer(parentPath: self.basePath.build(with: obj.id))
//    }
//    
//    /// Starts the query on the collection
//    public func startQuery() -> Query {
//        return firebaseSingleton.firestore.collection(basePath.build())
//    }
//    
//    /// Inserts an object or updates an existing object
//    /// - Parameter object: The object to be inserted or updated
//    public func insertOrUpdate(object: T) -> Bool {
//        if let id = object.id {
//            return firebaseSingleton.firestore.collection(basePath.build()).document(id).setValue(value: object)
//        }
//        return firebaseSingleton.firestore.collection(basePath.build()).document().setValue(value: object)
//    }
//    
//    /// Gets the object by it's id.
//    /// - Parameters:
//    ///   - id: The identification number of the object
//    ///   - asyncCompleteWithObject: Returns the object or nil if it doesn't exist
//    public func getBy(id: String, asyncCompleteWithObject: @escaping (Result<T, Error>) -> Void) {
//        firebaseSingleton.firestore.document(basePath.build(with: id)).getDocument { (result) in
//            asyncCompleteWithObject(result)
//        }
//    }
//    
//    /// Gets all documents within a collection
//    /// - Parameter asyncCompleteWithObjects: Contains the objects or error if objects could not be found
//    func getAll(asyncCompleteWithObjects: @escaping (Result<[T], Error>) -> Void) {
//        firebaseSingleton.firestore.collection(basePath.build()).getDocuments { (result: Result<[T], Error>) in
//            asyncCompleteWithObjects(result)
//        }
//    }
//    
//    /// Gets all objects that match the id's supplied
//    /// - Parameters:
//    ///   - ids: id's of the objects to be retrieved
//    ///   - asyncCompleteWithObjects: Contains the objects or error if objects could not be found
//    func getAllBy(ids: [String], asyncCompleteWithObjects: @escaping ([Result<T, Error>]) -> Void) {
//        var returnValuesDict = [Int: Result<T, Error>]()
//        var returnValue = [Result<T, Error>]()
//        for (index, id) in ids.enumerated() {
//            firebaseSingleton.firestore.document(basePath.build(with: id)).getDocument(forIndex: index) { (result: Result<T, Error>, index) in
//                returnValuesDict[index] = result
//                if returnValuesDict.count == ids.count {
//                    for i in 0...returnValuesDict.count {
//                        if let value = returnValuesDict[i] {
//                            returnValue.append(value)
//                        }
//                    }
//                    asyncCompleteWithObjects(returnValue)
//                }
//            }
//        }
//    }
//    
//    /// Get the object by it's id, with index tracking
//    /// - Parameters:
//    ///   - id: id of the object to be retrieved
//    ///   - forIndex: the index of the object in a list of objects that are being retrieved
//    ///   - asyncCompleteWithObject: Contains the object or error if the object could not be found
//    func getBy(id: String, forIndex: Int, asyncCompleteWithObject: @escaping (Result<T, Error>, Int) -> Void) {
//        self.getBy(id: basePath.build(with: id)) { (result) in
//            asyncCompleteWithObject(result, forIndex)
//        }
//    }
//    
//    /// Search within a whole collection of groups
//    /// - Parameter key: the key of the collection group querying through
//    func collectionGroup(key: Keys) -> Query {
//        return firebaseSingleton.firestore.collectionGroup(key.stringValue)
//    }
//    
//    func deleteBy(id: String) {
//        self.firebaseSingleton.firestore.document(self.basePath.build(with: id)).delete()
//    }
//    
//    func deleteAllBy(ids: [String]) {
//        for id in ids {
//            self.deleteBy(id: id)
//        }
//    }
//}
