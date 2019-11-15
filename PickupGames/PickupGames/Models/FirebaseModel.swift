////
////  FirebaseModel.swift
////  PickupGames
////
////  Created by Andrew Daniels on 9/23/19.
////  Copyright © 2019 Andrew Daniels. All rights reserved.
////
//
//import Foundation
//import UIKit
//import FirebaseDatabase
//
//class FirebaseModel: FirebaseCodable {
//
//    var referenceKey: String!
//
//    var paths: [[String] : Path] = [:]
//
//    var updateData: [String : Any] = [:]
//
//    func populate(completionHandler: @escaping (Bool) -> Void) {
//
//    }
//
//    required init(from decoder: Decoder) throws {
//
//    }
//
//    func get<T: FirebaseCodable>(completionHandler: @escaping (_ isResponse : T) -> Void) {
//
//        let path = paths.first { (p) -> Bool in
//            return p.value == .Model
//        }
//
//        guard let p = path?.key.first else { return }
//
//        FirebaseSingleton.instance.databaseRef.child(p).observeSingleEvent(of: .value) { (snapshot) in
//
//            guard let value = snapshot.value else { return }
//
//            do {
//                if JSONSerialization.isValidJSONObject(value) {
//
//                    let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
//                    let decoder = JSONDecoder()
//                    let result = try decoder.decode(T.self, from: jsonData)
//                    completionHandler(result)
//                }
//            } catch {
//                print("There was an error retrieving Codable Object at Path: \(p). \(error)")
//            }
//        }
//
//    }
//
//    internal static func get<T: FirebaseCodable>(operation: Operation, completionHandler: @escaping (_ isResponse : [T]) -> Void) {
//
//        guard let s = self as? FirebaseCodable else { return }
//
//        let path = s.paths.first { (p) -> Bool in
//            return p.value == .Model
//        }
//
//        guard let p = path?.key.first else { return }
//
//        if operation != .ImagesOnly {
//
//            FirebaseSingleton.instance.databaseRef.child(p).observeSingleEvent(of: .value) { (snapshot) in
//                guard let value = snapshot.value else { return }
//
//                do {
//                    let jsonData = try JSONSerialization.data(withJSONObject: value, options: [])
//                    let result = try JSONDecoder().decode([T].self, from: jsonData)
//
//                    completionHandler(result)
//                } catch {
//                    print("There was an error retrieving Array of Codable Objects.")
//                }
//            }
//        }
//
//        if operation != .ExcludingImages {
//
//
//        }
//    }
//
//    func save(completionHandler: @escaping (_ isResponse : Bool) -> Void) {
//
//        let path = paths.first { (p) -> Bool in
//            return p.value == .Model
//        }
//
//        guard let p = path?.key.first else { return }
//
//        let refKey: String! = referenceKey != nil ? referenceKey : FirebaseSingleton.instance.databaseRef.child(p).childByAutoId().key
//        let updates = [
//            p + "\(refKey!)": updateData
//        ]
//
//        FirebaseSingleton.instance.databaseRef.updateChildValues(updates)
//        completionHandler(true)
//    }
//
//    func getImages(renderMode: UIImage.RenderingMode = .alwaysOriginal, delegate: FirebaseCodableDelegate) {
//
//        guard paths.count > 1 else { return }
//
//        let pathParents = paths.filter { (path) -> Bool in
//            return path.value != .Model
//        }
//
//        for pathParent in pathParents.keys {
//
//            for (index, path) in pathParent.enumerated() {
//
//                FirebaseSingleton.instance.storageRef.child(path).getData(maxSize: 1024) { (data, err) in
//
//                    if let err = err {
//                        print("There was an error retrieving related images for FirebaseModel at path \(path) - Error: \(err)")
//                        return
//                    }
//
//                    if let data = data, let image = UIImage(data: data)?.withRenderingMode(renderMode) {
//
//                        delegate.downloaded(image: image, atPath: path, andIndex: index)
//
//                    }
//                }
//            }
//        }
//    }
//
//    func put(imagesInPath: [UIImage: String], complete: @escaping (_ isResponse: Bool) -> Void) {
//
//        var uploads = 0
//
//        for (image, path) in imagesInPath {
//
//            if let data = image.pngData() {
//
//                let photoRef = FirebaseSingleton.instance.storageRef.child(path)
//                photoRef.putData(data, metadata: nil) { (metadata, err) in
//                    guard let _ = metadata else {
//                        // Uh-oh, an error occurred!
//                        return
//                    }
//                    uploads += 1
//
//                    if uploads == imagesInPath.count {
//                        complete(true)
//                    }
//                }
//            }
//        }
//    }
//}
