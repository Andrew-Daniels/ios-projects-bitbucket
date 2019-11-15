//
//  FirebaseStorageLayer.swift
//  PickupGames
//
//  Created by Andrew Daniels on 11/11/19.
//  Copyright © 2019 Andrew Daniels. All rights reserved.
//

import Foundation
import UIKit

class FirebaseStorageLayer<T: FirebaseCodable, U: FirebaseStoreLayer<T>> {
    
    private var firebaseSingleton = FirebaseSingleton.instance
    private var firebaseStoreLayer: U!
    private var obj: T!
    
    init(obj: T, layer: U) {
        self.obj = obj
        self.firebaseStoreLayer = layer
    }
    
//    func saveImages(atPathWithData: [String: Data]) {
//        for (path, data) in atPathWithData {
//            let imageRef = firebaseSingleton.storageRef.child(path)
//            imageRef.putData(data, metadata: nil) { (metadata, err) in
//                guard let _ = metadata else { return }
//                imageRef.downloadURL { (url, error) in
//                    guard let downloadUrl = url else { return }
//
//                }
//            }
//        }
//    }
    func insert(image: UIImage, forKey: CodingKey, forIndex: Int, asyncCompleteWithObject: @escaping (URL?, Error?, Int) -> Void) {
        let date = Date().timeIntervalSince1970.description
        let imageRef = firebaseSingleton.storageRef.child(self.firebaseStoreLayer.basePath.pathBuilder(replacementStrings: obj.id, "\(forKey.stringValue)_\(forIndex)_\(date)"))
        guard let data = image.pngData() else { asyncCompleteWithObject(nil, nil, forIndex); return }
        imageRef.putData(data, metadata: nil) { (metadata, err) in
            imageRef.downloadURL { (url, error) in
                asyncCompleteWithObject(url, error, forIndex)
            }
        }
    }
    
    func insert(images: [UIImage], forKey: CodingKey, asyncCompleteWithObjects: @escaping ([URL?], Error?) -> Void) {
        var returnValuesDict = [Int: URL?]()
        var returnValue = [URL?]()
        for (index, image) in images.enumerated() {
            self.insert(image: image, forKey: forKey, forIndex: index) { (url, error, index) in
                returnValuesDict[index] = url
                if returnValuesDict.count == images.count {
                    for i in 0...returnValuesDict.count {
                        if let valueOptional = returnValuesDict[i], let value = valueOptional {
                            returnValue.append(value)
                        }
                    }
                    asyncCompleteWithObjects(returnValue, error)
                }
            }
        }
    }
}
