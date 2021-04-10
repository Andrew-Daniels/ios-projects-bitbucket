//
//  CompletionAthleteSelectorCollectionViewCell.swift
//  trainerapp
//
//  Created by Andrew Daniels on 3/22/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import UIKit

class CompletionAthleteSelectorCollectionViewCell: UICollectionViewCell {
    
    private var initialsLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor.TRblue
        lbl.font = UIFont(name: "Futura", size: 20)
        lbl.textAlignment = .center
        return lbl
    }()
    
    private var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor.TRfont
        lbl.font = UIFont(name: "Futura", size: 12)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private var profileImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.layer.borderColor = UIColor.TRblue.cgColor
        imgView.layer.borderWidth = 2
        imgView.layer.masksToBounds = true
        return imgView
    }()
    private var profileShadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.TRsecondary
        return view
    }()
    private var completedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.TRblue.withAlphaComponent(0.71)
        return view
    }()
    private var completedViewLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = UIColor.TRwhite
        lbl.font = UIFont(name: "Futura", size: 15)
        lbl.textAlignment = .center
        return lbl
    }()
    
    public var athlete: (Athlete, SessionWorkout?)! {
        didSet {
            self.initWithAthlete()
        }
    }
    public var type: AttendenceTableViewType!
    private var currentState: AthleteSelectorCollectionViewCellState = .deselected
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        completedView.layer.cornerRadius = completedView.frame.height / 2
        profileShadowView.layer.cornerRadius = profileShadowView.frame.width / 2.2
    }
    
    private func initWithAthlete() {
        setupViews()
    }
    
    public func setState(toState: CompletionAthleteSelectorCollectionViewType) {
        switch toState {
        case .complete:
            complete()
            break
        case .notComplete:
            notComplete()
            break
        }
    }
    
    public func setState(toStates: CompletionAthleteSelectorCollectionViewType...) {
        for state in toStates {
            setState(toState: state)
        }
    }
    
    private func notComplete() {
        completedView.isHidden = true
        completedViewLabel.isHidden = true
    }
    
    private func complete() {
        completedView.isHidden = false
        completedViewLabel.isHidden = false
    }
    
    private func setupViews() {
        
        initialsLabel.text = athlete.0.initials
        nameLabel.text = athlete.0.firstName + " " + athlete.0.lastName
        
        guard let completedTime = athlete.1?.workoutStats.first?.time else { return }
        completedViewLabel.text = String(completedTime)
    }
    
    private func setupConstraints() {
        
        self.contentView.addSubview(profileImageView)
        self.contentView.addSubview(initialsLabel)
        self.contentView.addSubview(completedView)
        self.contentView.addSubview(completedViewLabel)
        //self.contentView.addSubview(profileShadowView)
        self.contentView.addSubview(nameLabel)
        
        var trailing = NSLayoutConstraint(item: profileImageView, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        var leading = NSLayoutConstraint(item: profileImageView, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1.0, constant: 0.0)
        var height = NSLayoutConstraint(item: profileImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60.0)
        var top = NSLayoutConstraint(item: profileImageView, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .top, multiplier: 1.0, constant: 0.0)
        
        self.contentView.addConstraints([trailing, leading, height, top])
        
        var centerX = NSLayoutConstraint(item: initialsLabel, attribute: .centerX, relatedBy: .equal, toItem: profileImageView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        var centerY = NSLayoutConstraint(item: initialsLabel, attribute: .centerY, relatedBy: .equal, toItem: profileImageView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        
        self.contentView.addConstraints([centerX, centerY])
        
        trailing = NSLayoutConstraint(item: completedView, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        leading = NSLayoutConstraint(item: completedView, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1.0, constant: 0.0)
        height = NSLayoutConstraint(item: completedView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60.0)
        top = NSLayoutConstraint(item: completedView, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .top, multiplier: 1.0, constant: 0.0)
        
        self.contentView.addConstraints([trailing, leading, height, top])
        
        centerX = NSLayoutConstraint(item: completedViewLabel, attribute: .centerX, relatedBy: .equal, toItem: profileImageView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        centerY = NSLayoutConstraint(item: completedViewLabel, attribute: .centerY, relatedBy: .equal, toItem: profileImageView, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        
        self.contentView.addConstraints([centerX, centerY])
        
//        trailing = NSLayoutConstraint(item: profileShadowView, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1.0, constant: 1.0)
//        leading = NSLayoutConstraint(item: profileShadowView, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1.0, constant: 1.0)
//        let bottom = NSLayoutConstraint(item: profileShadowView, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1.0, constant: 1.0)
//        top = NSLayoutConstraint(item: profileShadowView, attribute: .top, relatedBy: .equal, toItem: profileImageView, attribute: .bottom, multiplier: 1.0, constant: 6.0)
//
//        self.contentView.addConstraints([trailing, leading, top, bottom])
        
        trailing = NSLayoutConstraint(item: nameLabel, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        leading = NSLayoutConstraint(item: nameLabel, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let bottom = NSLayoutConstraint(item: nameLabel, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        top = NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: profileImageView, attribute: .bottom, multiplier: 1.0, constant: 1.0)

        self.contentView.addConstraints([trailing, leading, top, bottom])
        
        self.layoutIfNeeded()
    }
}
