//
//  TableViewCell.swift
//  HavingFunMockup
//
//  Created by Andrew Daniels on 2/4/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var workoutName: UILabel!
    @IBOutlet weak var setNumberLabel: UILabel!
    @IBOutlet weak var repTextfield: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
