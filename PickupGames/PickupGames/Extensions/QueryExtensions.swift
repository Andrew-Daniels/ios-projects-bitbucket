//
//  QueryExtensions.swift
//  PickupGames
//
//  Created by Andrew Daniels on 11/9/19.
//  Copyright © 2019 Andrew Daniels. All rights reserved.
//

import Foundation
import Firebase

extension Query {
    func getDocuments<T: FirebaseCodable>(asyncCompletionWithObjects: @escaping (Result<[T], Error>) -> Void) {
        self.getDocuments { (docs, err) in
            if let err = err {
                asyncCompletionWithObjects(.failure(err))
            } else if let docs = docs?.documents {
                var returnVal = [T]()
                for document in docs {
                    do {
                        guard JSONSerialization.isValidJSONObject(document.data()) else { continue }
                        let jsonData = try JSONSerialization.data(withJSONObject: document.data(), options: [])
                        var docObj = try JSONDecoder().decode(T.self, from: jsonData)
                        docObj.id = document.documentID
                        returnVal.append(docObj)
                    } catch {
                        print("error serializing an object")
                    }
                }
                asyncCompletionWithObjects(.success(returnVal))
            }
            else {
                asyncCompletionWithObjects(.failure(FirestoreError.ObjectNotFound))
            }
        }
    }
    
    func getParentDocuments<T: FirebaseCodable>(asyncCompletionWithObjects: @escaping (Result<[Result<T, Error>], Error>) -> Void) {
        self.getDocuments { (snapshot, err) in
            if let err = err {
                asyncCompletionWithObjects(.failure(err))
            }
            var retDocs = [Result<T, Error>]()
            if let documents = snapshot?.documents {
                for doc in documents {
                    doc.reference.parent.parent?.getDocument(asyncCompleteWithObject: { (result: Result<T, Error>) in
                        retDocs.append(result)
                        if retDocs.count == documents.count {
                            asyncCompletionWithObjects(.success(retDocs))
                        }
                    })
                }
            } else {
                asyncCompletionWithObjects(.failure(FirestoreError.ObjectNotFound))
            }
        }
    }
    
    func parent<T: FirebaseCodable>(asyncCompletionWithObjects: @escaping (Result<[Result<T, Error>], Error>) -> Void) {
        self.getDocuments { (snapshot, err) in
            if let err = err {
                asyncCompletionWithObjects(.failure(err))
            }
            var retDocs = [Result<T, Error>]()
            if let documents = snapshot?.documents {
                for doc in documents {
                    doc.reference.parent.parent?.getDocument(asyncCompleteWithObject: { (result: Result<T, Error>) in
                        retDocs.append(result)
                        if retDocs.count == documents.count {
                            asyncCompletionWithObjects(.success(retDocs))
                        }
                    })
                }
            } else {
                asyncCompletionWithObjects(.failure(FirestoreError.ObjectNotFound))
            }
        }
    }
    
    func whereField(field: String, like: String) -> Query {
        return self.whereField(field, isGreaterThanOrEqualTo: like).whereField(field, isLessThanOrEqualTo: "\(like)\\uf8ff")
    }
    
    func whereField(path: FieldPath, like: String) -> Query {
        return self.whereField(path, isGreaterThanOrEqualTo: like).whereField(path, isLessThanOrEqualTo: "\(like)\\uf8ff")
    }
    
    func whereField(field: String, between value: Any, andValue: Any) -> Query {
        return self.whereField(field, isGreaterThanOrEqualTo: value).whereField(field, isLessThanOrEqualTo: andValue)
    }
    
    func whereArrayField(field: String, containsAllValues: [String]) -> Query {
        var query: Query!
        for value in containsAllValues {
            query = self.whereField(field, arrayContains: value)
        }
        return query
    }
}
