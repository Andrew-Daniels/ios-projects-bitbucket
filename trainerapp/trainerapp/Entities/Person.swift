//
//  Person.swift
//  trainerapp
//
//  Created by Andrew Daniels on 3/5/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import Foundation

protocol Person {
    
    var id: String! { get set }
    var firstName: String! { get set }
    var middleName: String? { get set }
    var lastName: String! { get set }
    var initials: String! { get set }
    
}
