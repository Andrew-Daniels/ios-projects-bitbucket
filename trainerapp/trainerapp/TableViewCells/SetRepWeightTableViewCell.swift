//
//  SetRepWeightTableViewCell.swift
//  trainerapp
//
//  Created by Andrew Daniels on 3/11/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import UIKit

protocol SetRepWeightTableViewCellDelegate {
    func workoutStatDidChange(workoutStat: WorkoutStat)
    func toolbarSaveClicked()
    func toolbarUndoClicked()
}

class SetRepWeightTableViewCell: UITableViewCell {
    
    public var workoutStat: WorkoutStat! {
        didSet {
            setLabel.text = String(workoutStat.set)
            repsTextField.text = String(workoutStat.reps ?? 10)
            weightTextField.text = String(workoutStat.weight ?? 0)
        }
    }
    
    public var delegate: SetRepWeightTableViewCellDelegate?
    
    private var setLabel: UILabel!
    private var repsTextField: UITextField!
    private var weightTextField: UITextField!
    private var controlStackView: UIStackView!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
        self.setupContraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupViews() {
        self.backgroundColor = UIColor.TRprimary
        self.selectionStyle = .none
        
        setLabel = UILabel()
        setLabel.font = UIFont(name: "Futura", size: 16.0)
        setLabel.textColor = UIColor.TRfont
        setLabel.translatesAutoresizingMaskIntoConstraints = false
        setLabel.textAlignment = .center
        
        let inputAccessoryView: UIView = {
            let backView = UIView()
            backView.backgroundColor = UIColor.TRprimary
            backView.translatesAutoresizingMaskIntoConstraints = false
            
            let lbl = UILabel()
            lbl.text = "test"
            
            backView.addSubview(lbl)
            lbl.sizeToFit()
            return backView
        }()
        
        repsTextField = UITextField()
        repsTextField.font = UIFont(name: "Futura", size: 16.0)
        repsTextField.textColor = UIColor.TRfont
        repsTextField.translatesAutoresizingMaskIntoConstraints = false
        repsTextField.textAlignment = .center
        repsTextField.keyboardType = .numberPad
        repsTextField.inputAccessoryView = inputAccessoryView
        repsTextField.inputAccessoryView?.sizeToFit()
        
        weightTextField = UITextField()
        weightTextField.font = UIFont(name: "Futura", size: 16.0)
        weightTextField.textColor = UIColor.TRfont
        weightTextField.translatesAutoresizingMaskIntoConstraints = false
        weightTextField.textAlignment = .center
        weightTextField.keyboardType = .numberPad
        //weightTextField.inputAccessoryView = inputAccessoryView
        
        controlStackView = UIStackView()
        controlStackView.addArrangedSubview(setLabel)
        controlStackView.addArrangedSubview(repsTextField)
        controlStackView.addArrangedSubview(weightTextField)
        controlStackView.axis = .horizontal
        controlStackView.translatesAutoresizingMaskIntoConstraints = false
        controlStackView.distribution = .fillEqually
        controlStackView.spacing = 0
        
        repsTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        weightTextField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        repsTextField.addTarget(self, action: #selector(textFieldTapped(textField:)), for: .touchDown)
        weightTextField.addTarget(self, action: #selector(textFieldTapped(textField:)), for: .touchDown)
    }
    
    private func setupContraints() {
        self.contentView.addSubview(controlStackView)
        
        let top = NSLayoutConstraint(item: controlStackView!, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .top, multiplier: 1.0, constant: 15.0)
        let bottom = NSLayoutConstraint(item: controlStackView!, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let leading = NSLayoutConstraint(item: controlStackView!, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailing = NSLayoutConstraint(item: controlStackView!, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        
        self.contentView.addConstraints([top, bottom, leading, trailing])
    }
    
    func focus() {
        self.repsTextField.becomeFirstResponder()
        self.repsTextField.selectAll(nil)
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        if textField == self.repsTextField, let text = textField.text {
            self.workoutStat.reps = Int(text)
            delegate?.workoutStatDidChange(workoutStat: self.workoutStat)
        }
        else if textField == self.weightTextField, let text = textField.text {
            self.workoutStat.weight = Int(text)
            delegate?.workoutStatDidChange(workoutStat: self.workoutStat)
        }
    }
    
    @objc func textFieldTapped(textField: UITextField) {
        textField.selectAll(nil)
    }
    
    @objc func saveBtnClicked() {
        delegate?.toolbarSaveClicked()
    }
    
    @objc func undoBtnClicked() {
        delegate?.toolbarUndoClicked()
    }
}
