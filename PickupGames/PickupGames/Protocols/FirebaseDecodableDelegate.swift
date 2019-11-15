//
//  FirebaseDecodableDelegate.swift
//  PickupGames
//
//  Created by Andrew Daniels on 9/23/19.
//  Copyright © 2019 Andrew Daniels. All rights reserved.
//

import Foundation
import UIKit

protocol FirebaseCodableDelegate {
    func downloaded(image: UIImage, atPath: String, andIndex: Int)
}
