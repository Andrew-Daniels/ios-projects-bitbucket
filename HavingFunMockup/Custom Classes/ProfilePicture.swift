//
//  ProfilePicture.swift
//  HavingFunMockup
//
//  Created by Andrew Daniels on 2/12/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import Foundation
import UIKit

class ProfilePicture {
    var radius: CGFloat = 35
    var borderColor = UIColor(displayP3Red: 33/255, green: 49/255, blue: 84/255, alpha: 1).cgColor
    var borderWidth: CGFloat = 4
    var tag = 0
    var image: UIImage?
    var initialsHidden = false
    var initials = ""
    var name = ""
    init(tag: Int, image: UIImage?, initials: String, name: String) {
        self.tag = tag
        self.image = image
        self.initials = initials
        self.name = name
        getHidden()
    }
    
    private func getHidden() {
        if let _ = image {
            initialsHidden = true
        }
    }
}
