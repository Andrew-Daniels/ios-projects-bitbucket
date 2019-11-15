//
//  ScheduleTableViewCell.swift
//  HavingFunMockup
//
//  Created by Andrew Daniels on 3/14/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {

    @IBOutlet weak var availableSpotsLabel: UILabel!
    @IBOutlet weak var availableSpotsView: UIView!
    @IBOutlet weak var instructorNameLabel: UILabel!
    @IBOutlet weak var timeSelectionButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
