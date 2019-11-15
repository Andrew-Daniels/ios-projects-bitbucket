//
//  PickupGameLayer.swift
//  PickupGames
//
//  Created by Andrew Daniels on 10/25/19.
//  Copyright © 2019 Andrew Daniels. All rights reserved.
//

import Foundation

class PickupGameLayer: FirebaseStoreLayer<PickupGame> {
    
    override init () {
        super.init()
        self.basePath = "pickupGames/{id}"
    }
    
    func subscribers(forPickupGame: PickupGame) -> PickupGameSubscriberLayer {
        return PickupGameSubscriberLayer(pickupGameLayerBasePath: self.basePath.pathBuilder(replacementStrings: forPickupGame.id))
    }
    
//    public func getBy(id: String, including: [PickupGame.Keys], asyncCompleteWithObject: @escaping (PickupGame?, Error?) -> Void) {
//        super.getBy(id: id) { (pug: PickupGame?, error) in
//            if let error = error {
//                asyncCompleteWithObject(nil, error)
//            }
//            else if including.count > 0, let pug = pug {
//                self.including(pickupGame: pug, including: including) { (pugIncluding, error) in
//                    asyncCompleteWithObject(pugIncluding, error)
//                }
//            }
//            else {
//                asyncCompleteWithObject(pug, error)
//            }
//        }
//    }
    
//    public func getBy(id: String, including: [PickupGame.Keys], notify: FirebaseCodableDownloading) {
//        super.getBy(id: id) { (pug: PickupGame?, error) in
//            if let error = error {
//                print(error)
//                return
//            }
//            else if including.count > 0, let pug = pug {
//                self.including(pickupGame: pug, including: including, notify: notify)
//            }
//        }
//    }
    
//    public func including(pickupGame: PickupGame, including: [PickupGame.Keys], asyncCompleteWithObject: @escaping (PickupGame?, Error?) -> Void) {
//        var completion = [PickupGame.Keys]()
//        for inc in including {
//            switch inc {
//            case .subscribers:
//                let arrayOfIds = pickupGame.subscriberPartials.map { $0.id ?? "" }
//                userLayer.getAllBy(ids: arrayOfIds) { (users: [User]?) in
//                    if let users = users {
//                        pickupGame.subscribers = users.enumerated().reduce(into: [Int: User]()) {
//                        $0[$1.0] = $1.1 }
//                    }
//                    completion.append(inc)
//                    if including.count == completion.count {
//                        asyncCompleteWithObject(pickupGame, nil)
//                    }
//                }
//                break
//            default:
//                completion.append(inc)
//                break
//            }
//        }
//        if including.count == completion.count {
//            asyncCompleteWithObject(pickupGame, nil)
//        }
//    }
    
//    public func including(pickupGame: PickupGame, including: [PickupGame.Keys], notify: FirebaseCodableDownloading) {
//        for inc in including {
//            switch inc {
//            case .subscribers:
//                let arrayOfIds = pickupGame.subscriberPartials.map { $0.id ?? "" }
//                for (index, id) in arrayOfIds.enumerated() {
//                    userLayer.getBy(id: id, forIndex: index) { (obj: User?, err, index) in
//                        if let obj = obj {
//                            pickupGame.subscribers[index] = obj
//                            notify.childDownloaded(parentId: pickupGame.id, childKey: inc.rawValue, childId: obj.id)
//                        }
//                    }
//                }
//                break
//            default:
//                break
//            }
//        }
//    }
}
