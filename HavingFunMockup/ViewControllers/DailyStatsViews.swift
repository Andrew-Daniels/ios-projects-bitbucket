//
//  DailyStatsViews.swift
//  HavingFunMockup
//
//  Created by Andrew Daniels on 2/15/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import UIKit

class DailyStatsViews: UIViewController {
    
    @IBOutlet weak var statTypeLabel: UILabel!
    @IBOutlet weak var actualStatLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var initialsLabel: UILabel!
    @IBOutlet weak var profileView: UIView!
    
    var actualStat = ""
    var initials = ""
    var profileImage: UIImage?
    var statHolderName = ""
    var statType = ""
    var athletes: [Athlete] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setProfilePicture(pp: loadData())
    }
    
    func loadData() -> ProfilePicture {
        let pp = ProfilePicture(tag: 1, image: profileImage, initials: initials, name: statHolderName)
        actualStatLabel.text = actualStat
        statTypeLabel.text = statType
        return pp
    }
    
    //MARK: - Profile Picture Functions
    
        func setProfilePicture(pp: ProfilePicture) {
            profileImageView.image = pp.image
            initialsLabel.isHidden = pp.initialsHidden
            initialsLabel.text = pp.initials
            profileImageView.layer.cornerRadius = CGFloat(pp.radius)
            profileImageView.layer.borderColor = pp.borderColor
            profileImageView.layer.borderWidth = CGFloat(pp.borderWidth)
            profileImageView.layer.masksToBounds = true
            profileImageView.backgroundColor = UIColor.white
        }

    
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
