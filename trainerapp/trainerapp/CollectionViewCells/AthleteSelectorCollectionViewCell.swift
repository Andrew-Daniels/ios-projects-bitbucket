//
//  AthleteSelectorCollectionViewCell.swift
//  trainerapp
//
//  Created by Andrew Daniels on 3/4/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import UIKit

enum AthleteSelectorCollectionViewCellState {
    case selected
    case unsaved
    case saved
    case none
    case deselected
}

class AthleteSelectorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var initialsLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    //@IBOutlet weak var profileShadowView: UIView!
    @IBOutlet weak var notSavedView: UIView!
    @IBOutlet weak var savedView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    public var athlete: Athlete! {
        didSet {
            self.initWithAthlete()
        }
    }
    public var type: AttendenceTableViewType!
    private var currentState: AthleteSelectorCollectionViewCellState = .deselected
    
    private func initWithAthlete() {
        guard let athlete = athlete else { return }
        
        initialsLabel.text = athlete.initials
        nameLabel.text = athlete.firstName + " " + athlete.lastName
        
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        profileImageView.layer.borderColor = UIColor.TRblue.cgColor
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.masksToBounds = true
        
        //profileShadowView.layer.cornerRadius = profileShadowView.frame.width / 2.2
        //profileShadowView.backgroundColor = UIColor.TRsecondary
        
        savedView.layer.cornerRadius = savedView.frame.height / 2
        notSavedView.layer.cornerRadius = notSavedView.frame.height / 2
    }
    
    public func setState(toState: AthleteSelectorCollectionViewCellState) {
        switch toState {
        case .saved:
            saved()
            break
        case .selected:
            select()
            break
        case .unsaved:
            unsavedChanges()
            break
        case .deselected:
            deselect()
            break
        case .none:
            clearOverlays()
            break
        }
    }
    
    public func setState(toStates: AthleteSelectorCollectionViewCellState...) {
        for state in toStates {
            setState(toState: state)
        }
    }
    
    private func select() {
        nameLabel.textColor = UIColor.TRblue
    }
    
    private func unsavedChanges() {
        notSavedView.isHidden = false
        savedView.isHidden = true
    }
    
    private func saved() {
        savedView.isHidden = false
        notSavedView.isHidden = true
    }
    
    private func deselect() {
        nameLabel.textColor = UIColor.TRfont
    }
    
    private func clearOverlays() {
        notSavedView.isHidden = true
        savedView.isHidden = true
    }
}
