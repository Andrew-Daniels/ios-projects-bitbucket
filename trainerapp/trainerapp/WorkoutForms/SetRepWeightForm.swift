//
//  SetRepWeightControl.swift
//  trainerapp
//
//  Created by Andrew Daniels on 3/7/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import UIKit

protocol WorkoutFormDelegate {
    func removeSession(session: SessionWorkout)
    func saveSession(session: SessionWorkout)
    func saveWorkout(onAthlete: Athlete, withWorkoutStats: [WorkoutStat])
    func changesMadeToWorkout(onAthlete: Athlete)
}

class SetRepWeightForm: WorkoutForm, SetRepWeightTableViewDelegate {
    
    var athlete: Athlete!
    var workoutStats: [WorkoutStat]!
    private var profileImageView: ProfileImageView!
    private var firstNameLabel: UILabel!
    private var lastNameLabel: UILabel!
    private var nameStackView: UIStackView!
    private var setLabel: UILabel!
    private var repsLabel: UILabel!
    private var weightLabel: UILabel!
    private var headerStackView: UIStackView!
    private var underscoreView: UIView!
    private var bottomToolbar: UIView!
    private var addSetBtn: UIButton!
    private var saveBtn: UIButton!
    private var setRepWeightTableView: SetRepWeightTableView!
    
    init(athlete: Athlete, withWorkoutStats: [WorkoutStat]) {
        super.init(frame: CGRect.zero)
        self.athlete = athlete
        self.workoutStats = withWorkoutStats
        setupViews()
        setupConstraints()
        
        addSetBtn.addTarget(self, action: #selector(addSetClicked), for: .touchUpInside)
        saveBtn.addTarget(self, action: #selector(saveClicked), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
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
        
        bottomToolbar = UIView()
        bottomToolbar.translatesAutoresizingMaskIntoConstraints = false
        bottomToolbar.backgroundColor = UIColor.TRsecondary
        
        addSetBtn = UIButton()
        addSetBtn.translatesAutoresizingMaskIntoConstraints = false
        addSetBtn.setTitleColor(UIColor.TRfont, for: .normal)
        addSetBtn.setTitle("Add a Set", for: .normal)
        addSetBtn.titleLabel?.font = UIFont(name: "Futura", size: 20)
        addSetBtn.setTitleColor(UIColor.TRsecondary, for: .highlighted)
        addSetBtn.setImage(UIImage(named: "Add_Open")?.withRenderingMode(.alwaysTemplate), for: .normal)
        addSetBtn.tintColor = UIColor.TRfont
        addSetBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        addSetBtn.sizeToFit()
        saveBtn = UIButton()
        saveBtn.translatesAutoresizingMaskIntoConstraints = false
        saveBtn.setTitleColor(UIColor.TRfont, for: .normal)
        saveBtn.setTitle("Save", for: .normal)
        saveBtn.setTitleColor(UIColor.TRsecondary, for: .highlighted)
        saveBtn.titleLabel?.font = UIFont(name: "Futura", size: 20)
        
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
        self.addSubview(bottomToolbar)
        self.bottomToolbar.addSubview(addSetBtn)
        self.bottomToolbar.addSubview(saveBtn)
        
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            profileImageView.heightAnchor.constraint(equalToConstant: 60),
            profileImageView.widthAnchor.constraint(equalToConstant: 60),
            profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            
            nameStackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            nameStackView.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: 0),
            
            headerStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            headerStackView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 30),
            headerStackView.widthAnchor.constraint(equalToConstant: 218),
            
            underscoreView.leadingAnchor.constraint(equalTo: headerStackView.leadingAnchor, constant: 0),
            underscoreView.trailingAnchor.constraint(equalTo: headerStackView.trailingAnchor, constant: 0),
            underscoreView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 15),
            underscoreView.heightAnchor.constraint(equalToConstant: 3),
            
            setRepWeightTableView.leadingAnchor.constraint(equalTo: underscoreView.leadingAnchor, constant: 0),
            setRepWeightTableView.trailingAnchor.constraint(equalTo: underscoreView.trailingAnchor, constant: 0),
            setRepWeightTableView.topAnchor.constraint(equalTo: underscoreView.bottomAnchor, constant: 0),
            setRepWeightTableView.bottomAnchor.constraint(equalTo: addSetBtn.topAnchor, constant: 5),
            
            bottomToolbar.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            bottomToolbar.heightAnchor.constraint(equalToConstant: 44),
            bottomToolbar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            bottomToolbar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            
            addSetBtn.centerXAnchor.constraint(equalTo: self.bottomToolbar.centerXAnchor, constant: 0),
            addSetBtn.widthAnchor.constraint(equalToConstant: addSetBtn.frame.width + 10),
            addSetBtn.centerYAnchor.constraint(equalTo: saveBtn.centerYAnchor, constant: 0),
            
            saveBtn.trailingAnchor.constraint(equalTo: self.bottomToolbar.trailingAnchor, constant: -20),
            saveBtn.bottomAnchor.constraint(equalTo: self.bottomToolbar.bottomAnchor, constant: 0),
            saveBtn.centerYAnchor.constraint(equalTo: self.bottomToolbar.centerYAnchor, constant: 0)
        ])
    }
    
    @objc func undoClicked(_ sender: UIButton) {
        delegate?.changesMadeToWorkout(onAthlete: athlete)
    }
    
    @objc func saveClicked(_ sender: UIButton) {
        delegate?.saveWorkout(onAthlete: athlete, withWorkoutStats: workoutStats)
    }
    
    @objc func addSetClicked(_ sender: UIButton) {
        self.setRepWeightTableView.addSet()
    }
    
    func toolbarSaveClicked() {
        saveClicked(saveBtn)
    }
    
    func toolbarUndoClicked() {
        undoClicked(addSetBtn)
    }
    
    func addSet(set: WorkoutStat) {
        self.workoutStats.removeAll { (ws) -> Bool in
            return ws.id == set.id
        }
        workoutStats.append(set)
        delegate?.changesMadeToWorkout(onAthlete: athlete)
    }
    
    func deleteSet(set: Int) {
        self.workoutStats = self.workoutStats.compactMap { ws in
            if ws.set == set { return nil }
            if ws.set < set { return ws }
            var newWs = ws
            newWs.set -= 1
            return newWs
        }
        delegate?.changesMadeToWorkout(onAthlete: athlete)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        // Get required info out of the notification
        if let scrollView = self.setRepWeightTableView, let userInfo = notification.userInfo, let endValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey], let durationValue = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey], let curveValue = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] {
            
            // Transform the keyboard's frame into our view's coordinate system
            let endRect = self.convert((endValue as AnyObject).cgRectValue, from: self.window)
            
            // Find out how much the keyboard overlaps our scroll view
            let keyboardOverlap = scrollView.frame.maxY - endRect.origin.y
            
            // Set the scroll view's content inset & scroll indicator to avoid the keyboard
            scrollView.contentInset.bottom = keyboardOverlap + 5
            scrollView.verticalScrollIndicatorInsets.bottom = keyboardOverlap + 5
            
            let duration = (durationValue as AnyObject).doubleValue
            let options = UIView.AnimationOptions(rawValue: UInt((curveValue as AnyObject).integerValue << 16))
            UIView.animate(withDuration: duration!, delay: 0, options: options, animations: {
                self.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let scrollView = self.setRepWeightTableView, let userInfo = notification.userInfo, let durationValue = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey], let curveValue = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] {
            
            scrollView.contentInset.bottom = 0
            scrollView.verticalScrollIndicatorInsets.bottom = 0
            
            let duration = (durationValue as AnyObject).doubleValue
            let options = UIView.AnimationOptions(rawValue: UInt((curveValue as AnyObject).integerValue << 16))
            UIView.animate(withDuration: duration!, delay: 0, options: options, animations: {
                self.layoutIfNeeded()
            }, completion: nil)
        }
    }
}
