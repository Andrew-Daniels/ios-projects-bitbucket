//
//  SessionWorkoutSelector.swift
//  trainerapp
//
//  Created by Andrew Daniels on 3/3/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import UIKit

protocol SessionWorkoutSelectorDelegate {
    func workoutSelectionChanged(workout: WorkoutType)
}

class SessionWorkoutSelectorView: UIView, SessionWorkoutSelectorTableViewDelegate {
    
    private var workouts: [WorkoutType]?
    private var selectedWorkout: WorkoutType?
    private var underlineHeight: CGFloat = 12.0
    private var underlineWidth: CGFloat = 21.0
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200.0, height: 50.0)
    }

    private var selectedWorkoutLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.TRfont
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.tag = 0
        lbl.font = UIFont(name: "Futura", size: 15)
        return lbl
    }()
    
    private var underline: UIImageView = {
        let img = UIImageView()
        let image = UIImage(named: "Underline_Chevron")?.withTintColor(UIColor.TRfont, renderingMode: .alwaysTemplate)
        img.image = image
        img.translatesAutoresizingMaskIntoConstraints = false
        img.tag = 1
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    public var sessionWorkoutSelectorTableView: SessionWorkoutSelectorTableView!
    public var delegate: SessionWorkoutSelectorDelegate?
    private var controlSuperView: UIView?
    
    init(workouts: [WorkoutType], superview: UIView?) {
        super.init(frame: CGRect.zero)
        self.workouts = workouts
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
    
    func workoutSelectionChanged(workout: WorkoutType) {
        Animator.animate(view: self.underline, withType: .Rotate180CounterClockwise)
        Animator.animate(view: self.sessionWorkoutSelectorTableView, withType: .ShrinkFadeOut)
        self.selectedWorkoutLabel.text = workout.title
        self.delegate?.workoutSelectionChanged(workout: workout)
    }
    
    @objc func workoutLabelTapped(_ sender: UIView) {
        Animator.animate(view: self.underline, withType: self.sessionWorkoutSelectorTableView.isHidden ? .Rotate180Clockwise : .Rotate180CounterClockwise)
        Animator.animate(view: self.sessionWorkoutSelectorTableView, withType: self.sessionWorkoutSelectorTableView.isHidden ? .ShrinkFadeIn : .ShrinkFadeOut)
    }
    
    private func initControl() {
        self.selectedWorkoutLabel.text = workouts?.first?.title
        self.selectedWorkout = workouts?.first
        self.clipsToBounds = false
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(workoutLabelTapped))
        gesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(gesture)
        self.sessionWorkoutSelectorTableView = SessionWorkoutSelectorTableView()
        self.sessionWorkoutSelectorTableView.workoutList = self.workouts
        self.sessionWorkoutSelectorTableView.controlDelegate = self
        self.sessionWorkoutSelectorTableView.translatesAutoresizingMaskIntoConstraints = false
        self.sessionWorkoutSelectorTableView.isHidden = true
        self.sessionWorkoutSelectorTableView.setup()
        setupConstraints()
    }

    private func setupConstraints() {
        
        self.addSubview(selectedWorkoutLabel)
        self.addSubview(underline)
        self.controlSuperView?.addSubview(sessionWorkoutSelectorTableView)
        
        NSLayoutConstraint.activate([
            selectedWorkoutLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            selectedWorkoutLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            
            underline.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            underline.topAnchor.constraint(equalTo: selectedWorkoutLabel.bottomAnchor, constant: 0),
            underline.heightAnchor.constraint(equalToConstant: underlineHeight),
            underline.widthAnchor.constraint(equalToConstant: underlineWidth),
            
            sessionWorkoutSelectorTableView.centerXAnchor.constraint(equalTo: self.controlSuperView!.centerXAnchor, constant: 0),
            sessionWorkoutSelectorTableView.widthAnchor.constraint(equalTo: self.controlSuperView!.widthAnchor, constant: 0),
        ])
        
        let top = NSLayoutConstraint(item: sessionWorkoutSelectorTableView!, attribute: .top, relatedBy: .equal, toItem: self.controlSuperView, attribute: .topMargin, multiplier: 1.0, constant: 0.0)
        let bottom = NSLayoutConstraint(item: sessionWorkoutSelectorTableView!, attribute: .bottom, relatedBy: .equal, toItem: self.controlSuperView, attribute: .bottomMargin, multiplier: 1.0, constant: 0.0)
        self.controlSuperView?.addConstraints([top, bottom])
    }
}
