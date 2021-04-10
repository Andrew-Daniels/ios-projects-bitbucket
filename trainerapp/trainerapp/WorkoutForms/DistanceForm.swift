//
//  DistanceForm.swift
//  trainerapp
//
//  Created by Andrew Daniels on 3/16/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import UIKit

class DistanceForm: WorkoutForm, CompletionAthleteSelectorDelegate, DistanceFormTimerViewDelegate {
    
    var athletes: [Athlete]!
    var sessionWorkouts: [SessionWorkout]!
    var workoutTypeId: String!
    var timer: TimerManagerSingleton.TimerInfo?
    private var notCompletedAthleteSelectorCollectionView: CompletionAthleteSelectorCollectionView!
    private var completedAthleteSelectorCollectionView: CompletionAthleteSelectorCollectionView!
    private var tipView: UIView!
    private var tipLabel: UILabel!
    private var sameTimeBtn: UIView!
    private var separateTimeBtn: UIView!
    private var distanceFormTimerView: DistanceFormTimerView!
    
    init(athletes: [Athlete], with sessionWorkouts: [SessionWorkout], for workoutTypeId: String) {
        super.init(frame: CGRect.zero)
        self.athletes = athletes
        self.sessionWorkouts = sessionWorkouts
        self.workoutTypeId = workoutTypeId
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    fileprivate func loadAthleteSelectorViews() {
        var completedAthletes: [(Athlete, SessionWorkout?)] = []
        var notCompleteAthletes: [(Athlete, SessionWorkout?)] = []
        for athlete in self.athletes ?? [] {
            let completedWorkout = self.sessionWorkouts?.first(where: { (sessionWorkout) -> Bool in
                return sessionWorkout.athleteId == athlete.id && sessionWorkout.completedDate != nil
            })
            if let completedWorkout = completedWorkout { completedAthletes.append((athlete, completedWorkout)) }
            else { notCompleteAthletes.append((athlete, completedWorkout)) }
        }
        
        notCompleteAthletes.sort { (left, right) -> Bool in
            return left.0.firstName < right.0.firstName
        }
        completedAthletes.sort { (left, right) -> Bool in
            return left.1!.completedDate > right.1!.completedDate
        }
        
        if completedAthleteSelectorCollectionView == nil {
            completedAthleteSelectorCollectionView = CompletionAthleteSelectorCollectionView(with: completedAthletes, type: .complete)
            completedAthleteSelectorCollectionView.translatesAutoresizingMaskIntoConstraints = false
            completedAthleteSelectorCollectionView.selectorDelegate = self
            
            notCompletedAthleteSelectorCollectionView = CompletionAthleteSelectorCollectionView(with: notCompleteAthletes, type: .notComplete)
            notCompletedAthleteSelectorCollectionView.translatesAutoresizingMaskIntoConstraints = false
            notCompletedAthleteSelectorCollectionView.selectorDelegate = self
        } else {
            completedAthleteSelectorCollectionView.athletes = completedAthletes
            notCompletedAthleteSelectorCollectionView.athletes = notCompleteAthletes
            
            completedAthleteSelectorCollectionView.reloadData()
            notCompletedAthleteSelectorCollectionView.reloadData()
        }
        tipView.isHidden = completedAthletes.count > 0
        tipLabel.isHidden = tipView.isHidden
        completedAthleteSelectorCollectionView.isHidden = !tipView.isHidden
        distanceFormTimerView.isHidden = completedAthleteSelectorCollectionView.isHidden
    }
    
    private func setupViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.TRprimary
        
        tipView = UIView()
        tipView.translatesAutoresizingMaskIntoConstraints = false
        tipView.backgroundColor = UIColor.TRsecondary
        
        tipLabel = UILabel()
        tipLabel.translatesAutoresizingMaskIntoConstraints = false
        tipLabel.textColor = UIColor.TRfont
        tipLabel.text = "Please select an option below."
        tipLabel.font = UIFont(name: "Futura", size: 25)
        
        var gesture = UITapGestureRecognizer(target: self, action: #selector(timeBtnTapped(_:)))
        gesture.numberOfTapsRequired = 1
        sameTimeBtn = UIView()
        sameTimeBtn.translatesAutoresizingMaskIntoConstraints = false
        sameTimeBtn.backgroundColor = UIColor.TRprimary
        sameTimeBtn.tag = 1
        sameTimeBtn.addGestureRecognizer(gesture)
        sameTimeBtn.isUserInteractionEnabled = true
        
        gesture = UITapGestureRecognizer(target: self, action: #selector(timeBtnTapped(_:)))
        gesture.numberOfTapsRequired = 1
        separateTimeBtn = UIView()
        separateTimeBtn.translatesAutoresizingMaskIntoConstraints = false
        separateTimeBtn.backgroundColor = UIColor.TRprimary
        separateTimeBtn.addGestureRecognizer(gesture)
        
        let fontAttr = [NSAttributedString.Key.font : UIFont(name: "Futura", size: 15), NSAttributedString.Key.foregroundColor : UIColor.TRfont]
        let redAttr = [NSAttributedString.Key.font : UIFont(name: "Futura", size: 15), NSAttributedString.Key.foregroundColor : UIColor.TRred]
        var fontString = NSMutableAttributedString(string:"All Athletes start workout ", attributes:fontAttr as [NSAttributedString.Key : Any])
        var redString = NSMutableAttributedString(string:"at the same time.", attributes:redAttr as [NSAttributedString.Key : Any])
        fontString.append(redString)
        
        let sameTimeLbl = UILabel()
        sameTimeLbl.translatesAutoresizingMaskIntoConstraints = false
        sameTimeLbl.attributedText = fontString
        
        sameTimeBtn.addSubview(sameTimeLbl)
        
        var centerX = NSLayoutConstraint(item: sameTimeLbl, attribute: .centerX, relatedBy: .equal, toItem: sameTimeBtn, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        var centerY = NSLayoutConstraint(item: sameTimeLbl, attribute: .centerY, relatedBy: .equal, toItem: sameTimeBtn, attribute: .centerY, multiplier: 1.0, constant: 0.0)

        sameTimeBtn.addConstraints([centerX, centerY])
        
        fontString = NSMutableAttributedString(string:"Each Athlete starts workout ", attributes:fontAttr as [NSAttributedString.Key : Any])
        redString = NSMutableAttributedString(string:"at different times.", attributes:redAttr as [NSAttributedString.Key : Any])
        fontString.append(redString)
        
        let separateTimeLbl = UILabel()
        separateTimeLbl.translatesAutoresizingMaskIntoConstraints = false
        separateTimeLbl.attributedText = fontString
        
        separateTimeBtn.addSubview(separateTimeLbl)
        
        centerX = NSLayoutConstraint(item: separateTimeLbl, attribute: .centerX, relatedBy: .equal, toItem: separateTimeBtn, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        centerY = NSLayoutConstraint(item: separateTimeLbl, attribute: .centerY, relatedBy: .equal, toItem: separateTimeBtn, attribute: .centerY, multiplier: 1.0, constant: 0.0)

        separateTimeBtn.addConstraints([centerX, centerY])
        
        distanceFormTimerView = DistanceFormTimerView(with: workoutTypeId)
        distanceFormTimerView.translatesAutoresizingMaskIntoConstraints = false
        distanceFormTimerView.isHidden = true
        distanceFormTimerView.delegate = self
        
        loadAthleteSelectorViews()
    }
    
    private func setupConstraints() {
        self.addSubview(notCompletedAthleteSelectorCollectionView)
        self.addSubview(tipView)
        self.addSubview(tipLabel)
        self.addSubview(completedAthleteSelectorCollectionView)
        self.addSubview(sameTimeBtn)
        self.addSubview(separateTimeBtn)
        self.addSubview(distanceFormTimerView)
        
        var leading = NSLayoutConstraint(item: notCompletedAthleteSelectorCollectionView!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
        var height = NSLayoutConstraint(item: notCompletedAthleteSelectorCollectionView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 120.0)
        var top = NSLayoutConstraint(item: notCompletedAthleteSelectorCollectionView!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0)
        var trailing = NSLayoutConstraint(item: notCompletedAthleteSelectorCollectionView!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0)

        self.addConstraints([leading, height, top, trailing])
        
        leading = NSLayoutConstraint(item: completedAthleteSelectorCollectionView!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
        height = NSLayoutConstraint(item: completedAthleteSelectorCollectionView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 120.0)
        top = NSLayoutConstraint(item: completedAthleteSelectorCollectionView!, attribute: .top, relatedBy: .equal, toItem: notCompletedAthleteSelectorCollectionView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        trailing = NSLayoutConstraint(item: completedAthleteSelectorCollectionView!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0)

        self.addConstraints([leading, height, top, trailing])
        
        leading = NSLayoutConstraint(item: tipView!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
        height = NSLayoutConstraint(item: tipView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 50.0)
        top = NSLayoutConstraint(item: tipView!, attribute: .top, relatedBy: .equal, toItem: notCompletedAthleteSelectorCollectionView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        trailing = NSLayoutConstraint(item: tipView!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0)

        self.addConstraints([leading, height, top, trailing])
        
        let centerX = NSLayoutConstraint(item: tipLabel!, attribute: .centerX, relatedBy: .equal, toItem: tipView, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        var centerY = NSLayoutConstraint(item: tipLabel!, attribute: .centerY, relatedBy: .equal, toItem: tipView, attribute: .centerY, multiplier: 1.0, constant: 0.0)

        self.addConstraints([centerX, centerY])
        
        leading = NSLayoutConstraint(item: sameTimeBtn!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
        trailing = NSLayoutConstraint(item: sameTimeBtn!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        height = NSLayoutConstraint(item: sameTimeBtn!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30.0)
        centerY = NSLayoutConstraint(item: sameTimeBtn!, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: -20.0)
        
        self.addConstraints([leading, trailing, centerY, height])
        
        leading = NSLayoutConstraint(item: separateTimeBtn!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
        trailing = NSLayoutConstraint(item: separateTimeBtn!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        height = NSLayoutConstraint(item: separateTimeBtn!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 30.0)
        centerY = NSLayoutConstraint(item: separateTimeBtn!, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 20.0)
        
        self.addConstraints([leading, trailing, centerY, height])
        
        leading = NSLayoutConstraint(item: distanceFormTimerView!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let bottom = NSLayoutConstraint(item: distanceFormTimerView!, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottomMargin, multiplier: 1.0, constant: 50.0)
        top = NSLayoutConstraint(item: distanceFormTimerView!, attribute: .top, relatedBy: .equal, toItem: completedAthleteSelectorCollectionView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        trailing = NSLayoutConstraint(item: distanceFormTimerView!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0)

        self.addConstraints([leading, bottom, top, trailing])
    }
    
    func athleteSelected(athlete: Athlete, completionType: CompletionAthleteSelectorCollectionViewType) {
        if !self.distanceFormTimerView.timerView.isTimerRunning() { return }
        
        switch completionType {
        case .complete:
            self.sessionWorkouts.removeAll { (sessionWorkout) -> Bool in
                if sessionWorkout.athleteId == athlete.id {
                    delegate?.removeSession(session: sessionWorkout)
                    return true
                }
                return false
            }
            break
        case .notComplete:
            var sessionWorkout = SessionWorkout()
            var workoutStat = WorkoutStat()
            workoutStat.time = self.distanceFormTimerView.timerView.getTimePassed()
            sessionWorkout.athleteId = athlete.id
            sessionWorkout.workoutTypeId = self.workoutTypeId
            sessionWorkout.workoutStats = [workoutStat]
            sessionWorkout.completedDate = Date()
            sessionWorkout.id = UUID().uuidString
            self.sessionWorkouts.append(sessionWorkout)
            delegate?.saveSession(session: sessionWorkout)
            break
        }
        
        loadAthleteSelectorViews()
    }
    
    @objc func timeBtnTapped(_ sender: UITapGestureRecognizer) {
        Animator.animate(animations: [
            Animation(view: self.distanceFormTimerView, type: .ShrinkFadeIn)
        ])
        tipLabel.text = ""
    }
    
    func timerStarted() {
        self.distanceFormTimerView.isHidden = false
        tipLabel.text = "Select athlete profile as they complete the workout."
        tipLabel.font = UIFont(name: "Futura", size: 15)
    }
    
    func timerStopped() {
        
    }
}
