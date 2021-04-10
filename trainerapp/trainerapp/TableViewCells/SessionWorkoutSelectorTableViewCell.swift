//
//  SessionWorkoutSelectorTableViewCell.swift
//  trainerapp
//
//  Created by Andrew Daniels on 3/15/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import UIKit

class SessionWorkoutSelectorTableViewCell: UITableViewCell {
    
    public var workout: WorkoutType! {
        didSet {
            self.workoutLabel.text = workout.title
        }
    }
    private var workoutLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Futura", size: 16.0)
        lbl.textColor = UIColor.TRfont
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        return lbl
    }()
    
    private var state: SessionWorkoutSelectorTableViewCellState = .notSelected
    private var workoutLabelLeadingConstraint: NSLayoutConstraint!
    
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
    }
    
    private func setupContraints() {
        self.contentView.addSubview(workoutLabel)
        
        let top = NSLayoutConstraint(item: workoutLabel, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .top, multiplier: 1.0, constant: 7.5)
        let bottom = NSLayoutConstraint(item: workoutLabel, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1.0, constant: -7.5)
        workoutLabelLeadingConstraint = NSLayoutConstraint(item: workoutLabel, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1.0, constant: self.state == .selected ? 0 : 27.0)
        let trailing = NSLayoutConstraint(item: workoutLabel, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        
        self.contentView.addConstraints([top, bottom, workoutLabelLeadingConstraint, trailing])
    }
    
    public func setState(state: SessionWorkoutSelectorTableViewCellState) {
        switch state {
        case .selected:
            selected()
        default:
            notSelected()
        }
    }
    
    private func selected() {
        self.accessoryType = .none
        self.workoutLabel.textColor = UIColor.TRred
        self.state = .selected
        self.workoutLabelLeadingConstraint.constant = 0
    }
    
    private func notSelected() {
        self.accessoryType = .disclosureIndicator
        self.workoutLabel.textColor = UIColor.TRfont
        self.state = .notSelected
        self.workoutLabelLeadingConstraint.constant = 27
    }

    enum SessionWorkoutSelectorTableViewCellState {
        case selected
        case notSelected
    }
}
