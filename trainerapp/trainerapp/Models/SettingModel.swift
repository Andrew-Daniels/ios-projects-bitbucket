//
//  SettingModel.swift
//  trainerapp
//
//  Created by Andrew Daniels on 8/8/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import UIKit

class SettingModel {
    var name: String!
    var hint: String?
    var section: String!
    var image: UIImage!
    
    init(name: String, hint: String?, section: String) {
        self.name = name
        self.hint = hint
        self.section = section
    }
}
