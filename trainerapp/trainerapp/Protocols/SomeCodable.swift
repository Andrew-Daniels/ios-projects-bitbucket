//
//  SomeCodable.swift
//  trainerapp
//
//  Created by Andrew Daniels on 3/2/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import Foundation

protocol SomeCodable: Codable {
    var id: String! { get set }
    init()
}
