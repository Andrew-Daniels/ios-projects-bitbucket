//
//  BaseTextfield.swift
//  PickupGames
//
//  Created by Andrew Daniels on 9/23/19.
//  Copyright © 2019 Andrew Daniels. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class BaseTextField: UIControl, UITextFieldDelegate {

    // MARK: Private Member Variables
    private var _text: String? {
        didSet {
            self.textField.text = self._text
            if let text = self._text, text.count > 0 {
                self.textFieldLabel.isHidden = false
            } else {
                self.textFieldLabel.isHidden = true
            }
        }
    }
    
    private var _hasError: Bool = false
    private var _borderColor: CGColor?
    
    // MARK: Public Member Variables
    public var hasError: Bool {
        get { return self._hasError }
    }
    
    public var text: String? {
        get { return self.textField.text }
        set { self._text = newValue }
    }
    
    // MARK: IBInspectable Variables
    @IBInspectable
    public var placeholderText: String? {
        didSet {
            if let placeholder = self.placeholderText {
                let attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: self.placeHolderTextColor ?? UIColor.lightGray])
                self.textField.attributedPlaceholder = attributedPlaceholder
                self.textFieldLabel.text = placeholder
            }
        }
    }
    
    @IBInspectable
    public var isNumberField: Bool = false {
        didSet {
            if isNumberField {
                self.textField.keyboardType = .decimalPad
            } else {
                self.textField.keyboardType = .default
            }
        }
    }
    
    @IBInspectable
    public var errorTextColor: UIColor? {
        didSet {
            self.errorLabel.textColor = self.errorTextColor
        }
    }
    
    @IBInspectable
    public var textFieldTextColor: UIColor? {
        didSet {
            self.textField.textColor = self.textFieldTextColor
            self._borderColor = self.textFieldTextColor?.cgColor
            self.textFieldLabel.textColor = self.textFieldTextColor
        }
    }
    
    @IBInspectable
    public var placeHolderTextColor: UIColor? {
        didSet {
            self.textField.attributedPlaceholder = NSAttributedString(string: self.placeholderText ?? "", attributes: [NSAttributedString.Key.foregroundColor: self.placeHolderTextColor ?? UIColor.lightGray])
        }
    }
    
    @IBInspectable
    public var textLimit: Int = 0
    
    // MARK: Member Variables
    var textField: UITextField = UITextField()
    var errorLabel: UILabel = UILabel()
    var textFieldLabel: UILabel = UILabel()
    //var delegate: MPTextFieldDelegate?
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initBaseTextField()
    }
    
    private func initBaseTextField() {
        //Add Textfield and ErrorLabel to MPTextField
        self.addSubview(self.textField)
        self.addSubview(self.errorLabel)
        self.addSubview(self.textFieldLabel)
        
        self.backgroundColor = .clear
        
        //Setup TextField
        self.textField.borderStyle = .none
        self.textField.delegate = self
        self.textField.textColor = UIColor.white
        self.textField.returnKeyType = .next
        self.textField.clearButtonMode = .whileEditing
        //self.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.textField.minimumFontSize = 10
        self.textField.adjustsFontSizeToFitWidth = true
        
        //Setup errorLabel
        var font = UIFont(name: "Helvetica", size: 12.0)
        self.errorLabel.font = font
        self.errorLabel.textColor = UIColor.white
        self.errorLabel.numberOfLines = 2
        
        //Setup textfield label
        font = UIFont(name: "Helvetica-Bold", size: 14.0)
        self.textFieldLabel.font = font
        self.textFieldLabel.textColor = UIColor.white
        self.textFieldLabel.isHidden = true
        
        //Setup constraints for TextField, ErrorLabel, and TextFieldLabel
        textField.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        textFieldLabel.translatesAutoresizingMaskIntoConstraints = false
        
        var topConstraint = (NSLayoutConstraint(item: textFieldLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 1.0))
        var leadingConstraint = (NSLayoutConstraint(item: textFieldLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0))
        var trailingConstraint = (NSLayoutConstraint(item: textFieldLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0))
        self.addConstraints([topConstraint, leadingConstraint, trailingConstraint])
        
        topConstraint = (NSLayoutConstraint(item: textField, attribute: .top, relatedBy: .equal, toItem: textFieldLabel, attribute: .bottom, multiplier: 1.0, constant: 1.0))
        leadingConstraint = (NSLayoutConstraint(item: textField, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0))
        trailingConstraint = (NSLayoutConstraint(item: textField, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0))
        self.addConstraints([topConstraint, leadingConstraint, trailingConstraint])
        
        topConstraint = (NSLayoutConstraint(item: errorLabel, attribute: .top, relatedBy: .equal, toItem: textField, attribute: .bottom, multiplier: 1.0, constant: 1.0))
        leadingConstraint = (NSLayoutConstraint(item: errorLabel, attribute: .leading, relatedBy: .equal, toItem: textField, attribute: .leading, multiplier: 1.0, constant: 0.0))
        trailingConstraint = (NSLayoutConstraint(item: errorLabel, attribute: .trailing, relatedBy: .equal, toItem: textField, attribute: .trailing, multiplier: 1.0, constant: 0.0))
        self.addConstraints([topConstraint, leadingConstraint, trailingConstraint])
    }
    
    // MARK: Personalization
    override func layoutSubviews() {
        super.layoutSubviews()
        self.useUnderline()
    }
    
    private func useUnderline() {
        let border = CALayer()
        let borderWidth = CGFloat(1.0)
        if let setColor = self._borderColor {
            border.borderColor = setColor
        }
        else
        {
            border.borderColor = UIColor.white.cgColor
        }
        border.frame = CGRect(x: 0, y: self.textField.frame.size.height - borderWidth, width: self.textField.frame.size.width, height: self.textField.frame.size.height)
        border.borderWidth = borderWidth
        self.textField.layer.addSublayer(border)
        self.textField.layer.masksToBounds = true
    }
    
    // MARK: Errors
    public func setError(errorMsg: String?) {
        if let errorMsg = errorMsg {
            self.errorLabel.text = errorMsg
            _hasError = true;
            animateError(numberOfShakes: 2.0, revert: true)
        }
    }
    
    public func setErrorNoShake(errorMsg: String?) {
        if let errorMsg = errorMsg {
            self.errorLabel.text = errorMsg
            _hasError = true;
        }
    }
    
    public func notifyOfError() {
        if (self._hasError) {
            self.animateError(numberOfShakes: 2.0, revert: true)
        }
    }
    
    private func animateError(numberOfShakes shakes: Float, revert: Bool) {
        let shake: CABasicAnimation = CABasicAnimation(keyPath: "position")
        shake.duration = 0.07
        shake.repeatCount = shakes
        if revert { shake.autoreverses = true  } else { shake.autoreverses = false }
        shake.fromValue = NSValue(cgPoint: CGPoint(x: self.textField.center.x - 10, y: self.textField.center.y))
        shake.toValue = NSValue(cgPoint: CGPoint(x: self.textField.center.x + 10, y: self.textField.center.y))
        self.textField.layer.add(shake, forKey: "position")
    }
    
    private func removeError() {
        errorLabel.text = ""
        _hasError = false
    }
    
    // MARK: UITextFieldDelegate
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if textLimit > 0 {
//            let currentString: NSString? = textField.text as NSString?
//            let newString: NSString? =
//                currentString?.replacingCharacters(in: range, with: string) as NSString?
//            if let text = newString, text.length > textLimit {
//                return false
//            }
//        }
//        if (self.authFieldType != .Username) {
//            self.removeError()
//        } else if self.authFieldType == .Username && self.hasError && self.text != ErrorHelper.getErrorMsg(errorKey: .UsernameTaken) {
//            self.removeError()
//        }
//        return true
//    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if let delegate = self.delegate {
//            delegate.mpTextFieldShouldReturn(textField: self)
//        }
//        return true;
//    }
    
    // MARK: EditingChanged Target
//    @objc func textFieldDidChange(_ textField: UITextField) {
//
//        if let text = self.text, text.count > 0 {
//            self.textFieldLabel.isHidden = false
//        } else {
//            self.textFieldLabel.isHidden = true
//        }
//
//        self.delegate?.mpTextFieldTextDidChange(text: textField.text)
//    }
    
    // MARK: FirstResponder Methods
    override func resignFirstResponder() -> Bool {
        if (self.textField.isFirstResponder) {
            self.textField.resignFirstResponder()
            return true
        }
        return false
    }
    override func becomeFirstResponder() -> Bool {
        if (!self.textField.isFirstResponder && self.textField.canBecomeFirstResponder) {
            self.textField.becomeFirstResponder()
            return true
        }
        return false
    }
}



