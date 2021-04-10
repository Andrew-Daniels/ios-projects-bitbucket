//
//  AttendanceTableViewCell.swift
//  trainerapp
//
//  Created by Andrew Daniels on 3/2/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import UIKit

class AttendanceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var initialsLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var stateControl: StateControl!
    
    public var athlete: Athlete! {
        didSet {
            self.initWithAthlete()
        }
    }
    public var type: AttendenceTableViewType!
    
    private func initWithAthlete() {
        guard let athlete = athlete else { return }
        
        initialsLabel.text = athlete.initials
        firstNameLabel.text = athlete.firstName
        lastNameLabel.text = athlete.lastName
        
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        profileImageView.layer.borderColor = UIColor.TRblue.cgColor
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.masksToBounds = true
    }

}
