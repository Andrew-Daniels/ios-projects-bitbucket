//
//  DocumentReferenceExtensions.swift
//  PickupGames
//
//  Created by Andrew Daniels on 11/9/19.
//  Copyright © 2019 Andrew Daniels. All rights reserved.
//

import Foundation
import Firebase

extension DocumentReference {
    func getDocument<T: FirebaseCodable>(asyncCompleteWithObject: @escaping (Result<T, Error>) -> Void) {
        self.getDocument { (document, err) in
            if let err = err {
                asyncCompleteWithObject(.failure(err))
            }
            else if let data = document?.data() {
                do {
                    guard JSONSerialization.isValidJSONObject(data) else { asyncCompleteWithObject(.failure(FirestoreError.InvalidJsonObject)); return }
                    let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                    var result = try JSONDecoder().decode(T.self, from: jsonData)
                    result.id = self.documentID
                    asyncCompleteWithObject(.success(result))
                } catch {
                    asyncCompleteWithObject(.failure(FirestoreError.DecodeJsonError))
                }
            }
            else {
                asyncCompleteWithObject(.failure(FirestoreError.ObjectNotFound))
            }
        }
    }
    
    func getDocument<T: FirebaseCodable>(forIndex: Int = 0, asyncCompleteWithObject: @escaping (Result<T, Error>, Int) -> Void) {
        self.getDocument { (document, err) in
            if let err = err {
                asyncCompleteWithObject(.failure(err), forIndex)
            }
            else if let data = document?.data() {
                do {
                    guard JSONSerialization.isValidJSONObject(data) else { asyncCompleteWithObject(.failure(FirestoreError.InvalidJsonObject), forIndex); return }
                    let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                    var result = try JSONDecoder().decode(T.self, from: jsonData)
                    result.id = self.documentID
                    asyncCompleteWithObject(.success(result), forIndex)
                } catch {
                    asyncCompleteWithObject(.failure(FirestoreError.DecodeJsonError), forIndex)
                }
            }
            else {
                asyncCompleteWithObject(.failure(FirestoreError.ObjectNotFound), forIndex)
            }
        }
    }
    
    func setValue<T: FirebaseCodable>(value: T) -> Bool {
        var mutValue = value
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .millisecondsSince1970
        guard let data = try? encoder.encode(value) else { return false }
        guard let documentData = ((try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap {
            $0 as? [String: Any]
        }) else { return false }
        self.setData(documentData)
        mutValue.id = self.documentID
        return true
    }
}

public enum FirestoreError: String, Error {
    case InvalidJsonObject = "The data received was not in JSON format"
    case DecodeJsonError = "JSON data was not in the expected object format"
    case ObjectNotFound = "Could not find object at path"
    
    var localizedDescription: String { return NSLocalizedString(self.rawValue, comment: "") }
}
