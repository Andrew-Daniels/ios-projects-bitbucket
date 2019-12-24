//
//  FIRDatabaseReferenceExtensions.swift
//  PickupGames
//
//  Created by Andrew Daniels on 10/27/19.
//  Copyright © 2019 Andrew Daniels. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

extension DatabaseQuery {
    func observeSingleEventSingleObject<T: FirebaseCodable>(eventType: DataEventType, asyncCompleteWithObject: @escaping (T?, Error?) -> Void) {
        self.observeSingleEvent(of: eventType) { (snapshot) in
            guard let value = snapshot.value else { return }
            
            do {
                guard JSONSerialization.isValidJSONObject(value) else { asyncCompleteWithObject(nil, nil); return }
                let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                var result = try JSONDecoder().decode(T.self, from: jsonData)
                result.id = snapshot.key
                asyncCompleteWithObject(result, nil)
            } catch {
                asyncCompleteWithObject(nil, error)
                print("There was an error retrieving of Decodable Object.")
            }
        }
    }
    
    func observeSingleEventAndSingleObject<T: FirebaseCodable>(eventType: DataEventType, forIndex: Int = 0, asyncCompleteWithObject: @escaping (T?, Error?, Int) -> Void) {
        self.observeSingleEvent(of: eventType) { (snapshot) in
            guard let value = snapshot.value else
            {
                asyncCompleteWithObject(nil, nil, forIndex)
                return
            }
            
            do {
                guard JSONSerialization.isValidJSONObject(value) else { asyncCompleteWithObject(nil, nil, forIndex); return }
                let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                var result = try JSONDecoder().decode(T.self, from: jsonData)
                result.id = snapshot.key
                asyncCompleteWithObject(result, nil, forIndex)
            } catch {
                asyncCompleteWithObject(nil, error, forIndex)
                print("There was an error retrieving of Decodable Object.")
            }
        }
    }
    
    func observeSingleEventAndArrayOfObjects<T: FirebaseCodable>(eventType: DataEventType, asyncCompleteWithObjects: @escaping ([T]?, Error?) -> Void) {
        self.observeSingleEvent(of: eventType) { (snapshot) in
            guard let value = snapshot.value else { return }

            do {
                guard JSONSerialization.isValidJSONObject(value) else { asyncCompleteWithObjects(nil, nil); return }
                let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
                let result = try JSONDecoder().decode([T].self, from: jsonData)

                asyncCompleteWithObjects(result, nil)
            } catch {
                print("There was an error retrieving Array of Decodable Objects.")
            }
        }
    }
}




