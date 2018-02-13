//
//  Athlete.swift
//  HavingFunMockup
//
//  Created by Andrew Daniels on 2/5/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import Foundation
import UIKit

class Athlete {
    var name = ""
    var profileImage: UIImage?
    init(name: String, profileImage: UIImage? = nil) {
        self.name = name
        self.profileImage = profileImage
    }
    
    func getInitials() -> String {
        var names = name.split(separator: " ", maxSplits: 2, omittingEmptySubsequences: true)
        var initials = ""
        if names.count == 3 {
            if let first = names[0].first, let last = names[2].first {
                initials = "\(first)\(last)"
            }
        } else if names.count == 2 {
            if let first = names[0].first, let last = names[1].first {
                initials = "\(first)\(last)"
            }
        } else if names.count == 1 {
            if let first = names[0].first {
                initials = "\(first)"
            }
        }
        return initials
    }
}
