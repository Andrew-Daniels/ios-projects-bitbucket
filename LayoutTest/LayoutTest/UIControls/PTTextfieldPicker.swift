//
//  PTTextfieldPicker.swift
//  LayoutTest
//
//  Created by Andrew Daniels on 1/18/20.
//  Copyright © 2020 Andrew Daniels. All rights reserved.
//

import UIKit

class PTTextfieldPicker: UIControl, UITextFieldDelegate {

    var textField: UITextField = UITextField()
    var textFieldLabel: UILabel = UILabel()
    var picker: UIPickerView = UIPickerView()
    var pickerOptions: [String]!
    var pickerDefault: String!
    
    @IBInspectable
    public var labelText: String? {
        didSet {
            textFieldLabel.text = labelText
        }
    }
    
    @IBInspectable
    public var placeHolderTextColor: UIColor? {
        didSet {
            self.textField.attributedPlaceholder = NSAttributedString(string: self.placeholderText ?? "", attributes: [NSAttributedString.Key.foregroundColor: self.placeHolderTextColor ?? UIColor.lightGray])
        }
    }
    
    @IBInspectable
    public var placeholderText: String? {
        didSet {
            if let placeholder = self.placeholderText {
                let attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: self.placeHolderTextColor ?? UIColor.lightGray])
                self.textField.attributedPlaceholder = attributedPlaceholder
            }
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupControl()
    }
    
    private func setupControl() {
        //Add Textfield and ErrorLabel to MPTextField
        self.addSubview(textField)
        self.addSubview(textFieldLabel)
        
        self.backgroundColor = .clear
        
        //Setup TextField
        //self.textField.borderStyle = .none
        self.textField.delegate = self
        self.textField.textColor = UIColor(named: "PTBlack")
        self.textField.minimumFontSize = 10
        self.textField.inputView = picker
        self.textField.backgroundColor = UIColor(named: "PTWhite")
        
        //Setup textfield label
        let font = UIFont(name: "Helvetica", size: 14.0)
        self.textFieldLabel.font = font
        self.textFieldLabel.textColor = UIColor(named: "PTBlack")
        self.textFieldLabel.numberOfLines = 1
        
        //Setup constraints for TextField, and TextFieldLabel
        textField.translatesAutoresizingMaskIntoConstraints = false
        textFieldLabel.translatesAutoresizingMaskIntoConstraints = false
        
        var topConstraint = (NSLayoutConstraint(item: textFieldLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0))
        var leadingConstraint = (NSLayoutConstraint(item: textFieldLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0))
        var trailingConstraint = (NSLayoutConstraint(item: textFieldLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0))
        self.addConstraints([topConstraint, leadingConstraint, trailingConstraint])
        
        topConstraint = (NSLayoutConstraint(item: textField, attribute: .top, relatedBy: .equal, toItem: textFieldLabel, attribute: .bottom, multiplier: 1.0, constant: 0.0))
        leadingConstraint = (NSLayoutConstraint(item: textField, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0))
        trailingConstraint = (NSLayoutConstraint(item: textField, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0))
        self.addConstraints([topConstraint, leadingConstraint, trailingConstraint])
    }
}
