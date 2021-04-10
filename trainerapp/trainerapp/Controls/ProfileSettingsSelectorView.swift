//
//  ProfileSettingsSelectorView.swift
//  trainerapp
//
//  Created by Andrew Daniels on 4/9/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import UIKit

protocol ProfileSettingsSelectorDelegate {
}

class ProfileSettingsSelectorView: UIView {
    
    public var delegate: ProfileSettingsSelectorDelegate?
    
    private var trainer: Trainer?
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200.0, height: 50.0)
    }

    private var firstNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.TRfont
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "Futura", size: 13)
        lbl.numberOfLines = 1
        return lbl
    }()
    
    private var lastNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.TRfont
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont(name: "Futura", size: 13)
        lbl.numberOfLines = 1
        return lbl
    }()
    
    private var profileImageView: UIImageView = {
        let img = UIImageView()
        let image = UIImage(named: "Andre_Giant")
        img.image = image
        img.translatesAutoresizingMaskIntoConstraints = false
        img.tag = 1
        img.contentMode = .scaleAspectFill
        img.layer.borderWidth = 1
        img.layer.borderColor = UIColor.TRfont.cgColor
        img.layer.cornerRadius = 3
        img.clipsToBounds = true
        return img
    }()
    
    private var nameStackView: UIStackView!
    private var controlSuperView: UIView?
    
    init(trainer: Trainer?, superview: UIView?) {
        super.init(frame: CGRect.zero)
        self.trainer = trainer
        self.controlSuperView = superview
        
        initControl()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initControl()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initControl()
    }
    
    @objc func trainerTapped(_ sender: UIView) {
        
    }
    
    private func initControl() {
        self.firstNameLabel.text = trainer?.firstName
        self.lastNameLabel.text = trainer?.lastName
        self.clipsToBounds = false
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(trainerTapped))
        gesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(gesture)
        
        nameStackView = UIStackView()
        nameStackView.addArrangedSubview(firstNameLabel)
        nameStackView.addArrangedSubview(lastNameLabel)
        nameStackView.axis = .vertical
        nameStackView.translatesAutoresizingMaskIntoConstraints = false
        
        setupConstraints()
    }

    private func setupConstraints() {
        
        self.addSubview(profileImageView)
        self.addSubview(nameStackView)
        
        NSLayoutConstraint.activate([
            profileImageView.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -2),
            profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            profileImageView.heightAnchor.constraint(equalToConstant: 33),
            profileImageView.widthAnchor.constraint(equalToConstant: 30),
            
            nameStackView.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: 2),
            nameStackView.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: 0)
        ])
    }
}

