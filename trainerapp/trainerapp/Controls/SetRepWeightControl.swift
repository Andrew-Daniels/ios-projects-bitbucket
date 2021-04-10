//
//  SetRepWeightControl.swift
//  trainerapp
//
//  Created by Andrew Daniels on 3/7/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import UIKit

protocol WorkoutFormDelegate {
    func saveWorkout(onAthlete: Athlete, withWorkoutStats: [WorkoutStat])
    func changesMadeToWorkout(onAthlete: Athlete)
}

class SetRepWeightForm: UIView, SetRepWeightTableViewDelegate {

    var athlete: Athlete!
    var workoutStats: [WorkoutStat]!
    var delegate: WorkoutFormDelegate?
    private var profileImageView: ProfileImageView!
    private var firstNameLabel: UILabel!
    private var lastNameLabel: UILabel!
    private var nameStackView: UIStackView!
    private var setLabel: UILabel!
    private var repsLabel: UILabel!
    private var weightLabel: UILabel!
    private var headerStackView: UIStackView!
    private var underscoreView: UIView!
    private var undoBtn: UIButton!
    private var saveBtn: UIButton!
    private var actionsStackView: UIStackView!
    private var setRepWeightTableView: SetRepWeightTableView!
    
    init(athlete: Athlete, withWorkoutStats: [WorkoutStat]) {
        super.init(frame: CGRect.zero)
        self.athlete = athlete
        self.workoutStats = withWorkoutStats
        setupViews()
        setupConstraints()
        
        undoBtn.addTarget(self, action: #selector(undoClicked), for: .touchUpInside)
        saveBtn.addTarget(self, action: #selector(saveClicked), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupViews() {
        self.backgroundColor = UIColor.TRprimary
        profileImageView = ProfileImageView(initials: athlete.initials, profileImage: nil)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        firstNameLabel = UILabel()
        firstNameLabel.textColor = UIColor.TRfont
        firstNameLabel.text = athlete.firstName
        firstNameLabel.translatesAutoresizingMaskIntoConstraints = false
        firstNameLabel.font = UIFont(name: "Futura", size: 20)
        lastNameLabel = UILabel()
        lastNameLabel.textColor = UIColor.TRfont
        lastNameLabel.text = athlete.lastName
        lastNameLabel.font = UIFont(name: "Futura", size: 20)
        lastNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameStackView = UIStackView()
        nameStackView.addArrangedSubview(firstNameLabel)
        nameStackView.addArrangedSubview(lastNameLabel)
        nameStackView.axis = .vertical
        nameStackView.translatesAutoresizingMaskIntoConstraints = false
        
        setLabel = UILabel()
        setLabel.textColor = UIColor.TRfont
        setLabel.text = "Set"
        setLabel.font = UIFont(name: "Futura", size: 20)
        setLabel.textAlignment = .center
        repsLabel = UILabel()
        repsLabel.textColor = UIColor.TRfont
        repsLabel.text = "Reps"
        repsLabel.font = UIFont(name: "Futura", size: 20)
        repsLabel.textAlignment = .center
        weightLabel = UILabel()
        weightLabel.textColor = UIColor.TRfont
        weightLabel.text = "Weight"
        weightLabel.font = UIFont(name: "Futura", size: 20)
        weightLabel.textAlignment = .center
        
        headerStackView = UIStackView()
        headerStackView.addArrangedSubview(setLabel)
        headerStackView.addArrangedSubview(repsLabel)
        headerStackView.addArrangedSubview(weightLabel)
        headerStackView.axis = .horizontal
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        headerStackView.distribution = .fillEqually
        headerStackView.spacing = 0
        
        undoBtn = UIButton()
        undoBtn.setTitleColor(UIColor.TRred, for: .normal)
        undoBtn.setTitle("Undo", for: .normal)
        undoBtn.titleLabel?.font = UIFont(name: "Futura", size: 20)
        saveBtn = UIButton()
        saveBtn.setTitleColor(UIColor.TRfont, for: .normal)
        saveBtn.setTitle("Save", for: .normal)
        saveBtn.titleLabel?.font = UIFont(name: "Futura", size: 20)
        
        actionsStackView = UIStackView()
        actionsStackView.addArrangedSubview(undoBtn)
        actionsStackView.addArrangedSubview(saveBtn)
        actionsStackView.axis = .horizontal
        actionsStackView.translatesAutoresizingMaskIntoConstraints = false
        actionsStackView.distribution = .equalSpacing
        actionsStackView.spacing = 0
        
        underscoreView = UIView()
        underscoreView.backgroundColor = UIColor.TRfont
        underscoreView.translatesAutoresizingMaskIntoConstraints = false
        
        setRepWeightTableView = SetRepWeightTableView()
        setRepWeightTableView.translatesAutoresizingMaskIntoConstraints = false
        setRepWeightTableView.workoutStats = workoutStats
        setRepWeightTableView.controlDelegate = self
    }
    
    private func setupConstraints() {
        self.addSubview(profileImageView)
        self.addSubview(nameStackView)
        self.addSubview(headerStackView)
        self.addSubview(underscoreView)
        self.addSubview(setRepWeightTableView)
        self.addSubview(actionsStackView)
        
        var leading = NSLayoutConstraint(item: profileImageView!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 50.0)
        var height = NSLayoutConstraint(item: profileImageView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60.0)
        var top = NSLayoutConstraint(item: profileImageView!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 10.0)
        var width = NSLayoutConstraint(item: profileImageView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60.0)
        
        self.addConstraints([leading, height, top, width])
        
        leading = NSLayoutConstraint(item: nameStackView!, attribute: .leading, relatedBy: .equal, toItem: profileImageView!, attribute: .trailing, multiplier: 1.0, constant: 10.0)
        var centerX = NSLayoutConstraint(item: nameStackView!, attribute: .centerY, relatedBy: .equal, toItem: profileImageView!, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        
        self.addConstraints([leading, centerX])
        
        centerX = NSLayoutConstraint(item: headerStackView!, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        top = NSLayoutConstraint(item: headerStackView!, attribute: .top, relatedBy: .equal, toItem: profileImageView!, attribute: .bottom, multiplier: 1.0, constant: 30.0)
        width = NSLayoutConstraint(item: headerStackView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 218.0)
        
        self.addConstraints([centerX, top, width])
        
        leading = NSLayoutConstraint(item: underscoreView!, attribute: .leading, relatedBy: .equal, toItem: headerStackView!, attribute: .leading, multiplier: 1.0, constant: 0.0)
        var trailing = NSLayoutConstraint(item: underscoreView!, attribute: .trailing, relatedBy: .equal, toItem: headerStackView!, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        top = NSLayoutConstraint(item: underscoreView!, attribute: .top, relatedBy: .equal, toItem: headerStackView!, attribute: .bottom, multiplier: 1.0, constant: 15.0)
        height = NSLayoutConstraint(item: underscoreView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 3.0)
        
        self.addConstraints([leading, trailing, top, height])
        
        leading = NSLayoutConstraint(item: setRepWeightTableView!, attribute: .leading, relatedBy: .equal, toItem: underscoreView!, attribute: .leading, multiplier: 1.0, constant: 0.0)
        trailing = NSLayoutConstraint(item: setRepWeightTableView!, attribute: .trailing, relatedBy: .equal, toItem: underscoreView!, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        top = NSLayoutConstraint(item: setRepWeightTableView!, attribute: .top, relatedBy: .equal, toItem: underscoreView!, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        var bottom = NSLayoutConstraint(item: setRepWeightTableView!, attribute: .bottom, relatedBy: .equal, toItem: actionsStackView!, attribute: .top, multiplier: 1.0, constant: 5.0)
        
        self.addConstraints([leading, trailing, top, bottom])
        
        leading = NSLayoutConstraint(item: actionsStackView!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 55.0)
        bottom = NSLayoutConstraint(item: actionsStackView!, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottomMargin, multiplier: 1.0, constant: 0.0)
        trailing = NSLayoutConstraint(item: actionsStackView!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: -55.0)
        
        self.addConstraints([leading, bottom, trailing])
    }

    @objc func undoClicked(_ sender: UIButton) {
        delegate?.changesMadeToWorkout(onAthlete: athlete)
    }
    
    @objc func saveClicked(_ sender: UIButton) {
        delegate?.saveWorkout(onAthlete: athlete, withWorkoutStats: workoutStats)
    }
    
    func addSet(set: WorkoutStat) {
        workoutStats.append(set)
        delegate?.changesMadeToWorkout(onAthlete: athlete)
    }
}
