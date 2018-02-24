//
//  CollectionViewCell.swift
//  HavingFunMockup
//
//  Created by Andrew Daniels on 2/2/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var initialsLabel: UILabel!
    var name = ""
    
    func profilePicture(pp: ProfilePicture) {
        profileImageView.image = pp.image
        initialsLabel.isHidden = pp.initialsHidden
        initialsLabel.text = pp.initials
        self.name = pp.name
        self.layer.cornerRadius = CGFloat(pp.radius)
        self.layer.borderColor = pp.borderColor
        self.layer.borderWidth = CGFloat(pp.borderWidth)
    }
    func getProfilePicture() -> ProfilePicture {
        if let actualInitials = initialsLabel.text {
            let pp = ProfilePicture(tag: self.tag, image: profileImageView.image, initials: actualInitials, name: name)
            return pp
        }
        let pp = ProfilePicture(tag: self.tag, image: profileImageView.image, initials: "", name: name)
        return pp
    }
    
}
