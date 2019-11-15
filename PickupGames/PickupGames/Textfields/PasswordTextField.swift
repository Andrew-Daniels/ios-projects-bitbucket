//
//  PasswordTextField.swift
//  PickupGames
//
//  Created by Andrew Daniels on 9/23/19.
//  Copyright © 2019 Andrew Daniels. All rights reserved.
//

import UIKit

class PasswordTextField: BaseTextField {
    
    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.textField.isSecureTextEntry = true
        self.textField.returnKeyType = .done
    }

    // MARK: EditingChanged Target
//    @objc override func textFieldDidChange(_ textField: UITextField) {
//        
//        super.textFieldDidChange(textField)
//        
//        let errorMsg = ValidationHelper.validatePassword(password: text)
//        self.setErrorNoShake(errorMsg: errorMsg)
//    }

}
