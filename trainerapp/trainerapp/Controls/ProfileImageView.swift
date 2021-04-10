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
        
        var leading = NSLayoutConstraint(item: profileImageView!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
        var trailing = NSLayoutConstraint(item: profileImageView!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        var top = NSLayoutConstraint(item: profileImageView!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0)
        var bottom = NSLayoutConstraint(item: profileImageView!, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        
        self.addConstraints([leading, trailing, top, bottom])
        
        leading = NSLayoutConstraint(item: initialsLabel!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
        trailing = NSLayoutConstraint(item: initialsLabel!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        top = NSLayoutConstraint(item: initialsLabel!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0)
        bottom = NSLayoutConstraint(item: initialsLabel!, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        
        self.addConstraints([leading, trailing, top, bottom])
    }
    
}
