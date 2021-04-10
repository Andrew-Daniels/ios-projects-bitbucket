//
//  ProfileImageView.swift
//  trainerapp
//
//  Created by Andrew Daniels on 3/11/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import UIKit

class ProfileImageView: UIView {

    private var profileImageView: UIImageView!
    private var initialsLabel: UILabel!
    var initials: String!
    var profileImage: UIImage?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(initials: String, profileImage: UIImage?) {
        super.init(frame: CGRect.zero)
        self.initials = initials
        self.profileImage = profileImage
        setupViews()
        setupConstraints()
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
    }
    
    private func setupViews() {
        profileImageView = UIImageView()
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.image = profileImage
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        profileImageView.layer.borderColor = UIColor.TRblue.cgColor
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.masksToBounds = true
        profileImageView.backgroundColor = UIColor.TRprimary
        
        initialsLabel = UILabel()
        initialsLabel.translatesAutoresizingMaskIntoConstraints = false
        initialsLabel.text = initials
        initialsLabel.isHidden = profileImage != nil
        initialsLabel.textColor = UIColor.TRfont
        initialsLabel.font = UIFont(name: "Futura", size: 20)
        initialsLabel.textAlignment = .center
    }
    
    private func setupConstraints() {
        self.addSubview(profileImageView)
        self.addSubview(initialsLabel)
        
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            profileImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            profileImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            
            initialsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            initialsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            initialsLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            initialsLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
        ])
    }
    
}
