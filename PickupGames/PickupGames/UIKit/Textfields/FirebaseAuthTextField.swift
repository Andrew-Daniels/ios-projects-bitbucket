//
//  FirebaseAuthTextField.swift
//  PickupGames
//
//  Created by Andrew Daniels on 9/23/19.
//  Copyright © 2019 Andrew Daniels. All rights reserved.
//

import UIKit
import Foundation

class FirebaseAuthTextField: BaseTextField {
    
    // MARK: EditingChanged Target
//    @objc override func textFieldDidChange(_ textField: UITextField) {
//        if let text = self.text, text.count > 1 {
//            if authFieldType == .Username {
//                FirebaseHelper().checkUsernameAvailability(username: self.text) { (available) in
//                    if (!available) {
//                        self.setError(errorMsg: ErrorHelper.getErrorMsg(errorKey: .UsernameTaken))
//                    } else {
//                        self.removeError()
//                    }
//                }
//            }
//        }
//        else if let text = self.text, text.count > 0 {
//            self.textFieldLabel.isHidden = false
//        } else {
//            self.textFieldLabel.isHidden = true
//        }
//
//        self.delegate?.mpTextFieldTextDidChange(text: textField.text)
//    }

}
