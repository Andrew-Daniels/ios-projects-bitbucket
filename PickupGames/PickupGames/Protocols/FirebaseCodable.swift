//
//  FirebaseDecodable.swift
//  PickupGames
//
//  Created by Andrew Daniels on 9/23/19.
//  Copyright © 2019 Andrew Daniels. All rights reserved.
//

import Foundation

protocol FirebaseCodable: Codable {
    var id: String! { get set }
}

protocol FirebaseCodableDownloading {
    func childDownloaded(parentId: String, childKey: String, childId: String)
}
