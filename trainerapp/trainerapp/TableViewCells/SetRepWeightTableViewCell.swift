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
    func toolbarAddSetClicked()
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
            backView.backgroundColor = UIColor.TRsecondary
            backView.autoresizingMask = .flexibleHeight
            backView.frame = CGRect(x: 0, y: 0, width: 0, height: 40)
            
            let cancelBtn = UIButton()
            cancelBtn.setTitle("Cancel", for: .normal)
            cancelBtn.translatesAutoresizingMaskIntoConstraints = false
            cancelBtn.setTitleColor(UIColor.TRred, for: .normal)
            cancelBtn.setTitleColor(UIColor.TRsecondary, for: .highlighted)
            cancelBtn.titleLabel?.font = UIFont(name: "Futura", size: 20)
            cancelBtn.addTarget(self, action: #selector(cancelBtnClicked), for: .touchUpInside)
            
            let addSetBtn = UIButton()
            addSetBtn.setTitle("Add a Set", for: .normal)
            addSetBtn.translatesAutoresizingMaskIntoConstraints = false
            addSetBtn.setTitleColor(UIColor.TRfont, for: .normal)
            addSetBtn.setTitleColor(UIColor.TRsecondary, for: .highlighted)
            addSetBtn.titleLabel?.font = UIFont(name: "Futura", size: 20)
            addSetBtn.addTarget(self, action: #selector(addSetBtnClicked), for: .touchUpInside)
            addSetBtn.setImage(UIImage(named: "Add_Open")?.withRenderingMode(.alwaysTemplate), for: .normal)
            addSetBtn.tintColor = UIColor.TRfont
            addSetBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
            addSetBtn.sizeToFit()
            
            let saveBtn = UIButton()
            saveBtn.setTitle("Save", for: .normal)
            saveBtn.translatesAutoresizingMaskIntoConstraints = false
            saveBtn.setTitleColor(UIColor.TRfont, for: .normal)
            saveBtn.setTitleColor(UIColor.TRsecondary, for: .highlighted)
            saveBtn.titleLabel?.font = UIFont(name: "Futura", size: 20)
            saveBtn.addTarget(self, action: #selector(saveBtnClicked), for: .touchUpInside)
            
            backView.addSubview(cancelBtn)
            backView.addSubview(saveBtn)
            backView.addSubview(addSetBtn)
            
            addSetBtn.centerXAnchor.constraint(equalTo: backView.centerXAnchor, constant: 0).isActive = true
            addSetBtn.centerYAnchor.constraint(equalTo: backView.centerYAnchor, constant: 0).isActive = true
            addSetBtn.widthAnchor.constraint(equalToConstant: addSetBtn.frame.width + 10).isActive = true
            
            cancelBtn.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 20).isActive = true
            cancelBtn.centerYAnchor.constraint(equalTo: addSetBtn.centerYAnchor, constant: 0).isActive = true
            
            saveBtn.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -20).isActive = true
            saveBtn.centerYAnchor.constraint(equalTo: addSetBtn.centerYAnchor, constant: 0).isActive = true

            return backView
        }()
        
        repsTextField = UITextField()
        repsTextField.font = UIFont(name: "Futura", size: 16.0)
        repsTextField.textColor = UIColor.TRfont
        repsTextField.translatesAutoresizingMaskIntoConstraints = false
        repsTextField.textAlignment = .center
        repsTextField.keyboardType = .numberPad
        repsTextField.inputAccessoryView = inputAccessoryView
        
        weightTextField = UITextField()
        weightTextField.font = UIFont(name: "Futura", size: 16.0)
        weightTextField.textColor = UIColor.TRfont
        weightTextField.translatesAutoresizingMaskIntoConstraints = false
        weightTextField.textAlignment = .center
        weightTextField.keyboardType = .numberPad
        weightTextField.inputAccessoryView = inputAccessoryView
        
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
    
    @objc func cancelBtnClicked() {
        self.endEditing(true)
    }
    
    @objc func addSetBtnClicked() {
        delegate?.toolbarAddSetClicked()
    }
}
