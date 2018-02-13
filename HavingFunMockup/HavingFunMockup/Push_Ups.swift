//
//  Push_Ups.swift
//  HavingFunMockup
//
//  Created by Andrew Daniels on 2/9/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import UIKit

class Push_Ups: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "Push_Ups", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }

}
