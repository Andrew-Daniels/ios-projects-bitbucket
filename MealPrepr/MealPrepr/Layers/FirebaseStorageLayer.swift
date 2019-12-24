//
//  FirebaseStorageLayer.swift
//  PickupGames
//
//  Created by Andrew Daniels on 11/11/19.
//  Copyright © 2019 Andrew Daniels. All rights reserved.
//

import Foundation
import UIKit

class FirebaseStorageLayer<Keys: CodingKey> {
    
    private var firebaseSingleton = FirebaseSingleton.instance
    private var parentPath: Path!
    
    init(parentPath: String) {
        self.parentPath = Path()
        self.parentPath.value = parentPath
    }
    
    func delete(image withUrl: URL, asyncCompleteWithObject: @escaping (Result<Bool, Error>) -> Void) {
        firebaseSingleton.storage.reference(forURL: withUrl.absoluteString).delete { (err) in
            if let err = err {
                asyncCompleteWithObject(.failure(err))
            } else {
                asyncCompleteWithObject(.success(true))
            }
        }
    }
    
    func insert(image: UIImage, withQuality: UIImage.JPEGQuality, forKey: Keys, forIndex: Int, asyncCompleteWithObject: @escaping (Result<URL, Error>, Int) -> Void) {
        let date = Date().timeIntervalSince1970.description
        let imageRef = firebaseSingleton.storageRef.child(parentPath.build(with: "\(forKey.stringValue)_\(forIndex)_\(date)"))
        guard let data = image.jpeg(withQuality) else { asyncCompleteWithObject(.failure(FirebaseStorageError.ImageDataParsingError), forIndex); return }
        imageRef.putData(data, metadata: nil) { (metadata, err) in
            imageRef.downloadURL { (url, error) in
                if let err = error {
                    asyncCompleteWithObject(.failure(err), forIndex)
                } else if let url = url {
                    asyncCompleteWithObject(.success(url), forIndex)
                } else {
                    asyncCompleteWithObject(.failure(FirebaseStorageError.Undefined), forIndex)
                }
            }
        }
    }
    
    func insert(images: [UIImage], withQuality: UIImage.JPEGQuality, forKey: Keys, asyncCompleteWithObjects: @escaping (Result<[(Result<URL, Error>, Int)], Error>) -> Void) {
        var returnValuesDict = [Int: (Result<URL, Error>, Int)]()
        var returnValue = [(Result<URL, Error>, Int)]()
        for (index, image) in images.enumerated() {
            self.insert(image: image, withQuality: withQuality, forKey: forKey, forIndex: index) { (result, index) in
                returnValuesDict[index] = (result, index)
                if returnValuesDict.count == images.count {
                    for i in 0...returnValuesDict.count {
                        if let value = returnValuesDict[i] {
                            returnValue.append(value)
                        }
                    }
                    asyncCompleteWithObjects(.success(returnValue))
                }
            }
        }
    }
    
    public enum FirebaseStorageError: Error {
        case ImageDataParsingError
        case Undefined
    }
}
