//
//  SessionViewController.swift
//  trainerapp
//
//  Created by Andrew Daniels on 3/3/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import UIKit

class SessionViewController: UIViewController, AthleteSelectorDelegate, WorkoutFormDelegate, SessionWorkoutSelectorDelegate {
    
    @IBOutlet weak var athleteSelectorCollectionView: AthleteSelectorCollectionView!
    @IBOutlet weak var separationView: UIView!
    
    private var sessionLayer: SessionLayer!
    private var session: Session?
    private var selectedWorkout: WorkoutType!
    private var selectedAthlete: Athlete?
    private var formContainer: UIView!
    private var formContainerInstructionLabel: UILabel!
    private var activeForm: WorkoutForm?
    
    private var formContainerTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupContraints()
        
        self.sessionLayer = EntityFactorySingleton.instance.sessions
        sessionLayer.getAll { (result) in
            switch result {
            case .success(let results):
                self.session = results.first
                let sessionWorkoutSelectorView = SessionWorkoutSelectorView(workouts: self.session?.workouts ?? [], superview: self.view)
                sessionWorkoutSelectorView.delegate = self
                self.navigationItem.titleView = sessionWorkoutSelectorView
                self.athleteSelectorCollectionView.selectorDelegate = self
                self.workoutSelectionChanged(workout: self.session!.workouts.first!)
                break
            case .failure(let err):
                print(err)
                break
            }
        }
    }
    
    func workoutSelectionChanged(workout: WorkoutType) {
        self.selectedWorkout = workout
        let formToHide = self.activeForm
        self.reloadAthleteSelector()
        switch self.selectedWorkout.formType {
        case .Distance:
            setFullScreenFormMode(on: true)
            break
        default:
            setFullScreenFormMode(on: false)
            break
        }
        let selectedIndexOfAthlete = self.athleteSelectorCollectionView.selectedIndex
        self.showForm(forAthlete: selectedIndexOfAthlete != nil && (self.session?.athletes?.count ?? 0) > selectedIndexOfAthlete! ? self.session?.athletes?[selectedIndexOfAthlete!] : nil)
        self.hideForm(formToHide: formToHide)
    }
    
    func athleteSelected(athlete: Athlete) {
        refreshSession(forAthlete: athlete)
        showForm(forAthlete: athlete)
    }
    
    private func refreshSession(forAthlete: Athlete) {
        if let selectedAthlete = self.selectedAthlete {
            if let existingSessionWorkoutIndex = session?.loggedWorkouts?.firstIndex(where: { (sessionWorkout) -> Bool in
                return sessionWorkout.athleteId == selectedAthlete.id && sessionWorkout.workoutTypeId == selectedWorkout.id && sessionWorkout.state == .editing
            }), var existingSessionWorkout = session?.loggedWorkouts?[existingSessionWorkoutIndex] {
                existingSessionWorkout.state = existingSessionWorkout.workoutStats?.count ?? 0 > 0 ? .saved : .none
                session?.loggedWorkouts?.remove(at: existingSessionWorkoutIndex)
                session?.loggedWorkouts?.append(existingSessionWorkout)
                self.reloadAthleteSelector()
            }
        }
        self.selectedAthlete = forAthlete
    }
    
    func saveWorkout(onAthlete: Athlete, withWorkoutStats: [WorkoutStat]) {
        if let existingSessionWorkoutIndex = session?.loggedWorkouts?.firstIndex(where: { (sessionWorkout) -> Bool in
            return sessionWorkout.athleteId == onAthlete.id && sessionWorkout.workoutTypeId == selectedWorkout.id
        }), var existingSessionWorkout = session?.loggedWorkouts?[existingSessionWorkoutIndex] {
            existingSessionWorkout.state = .saved
            existingSessionWorkout.workoutStats = withWorkoutStats
            existingSessionWorkout.completedDate = Date()
            session?.loggedWorkouts?.remove(at: existingSessionWorkoutIndex)
            session?.loggedWorkouts?.append(existingSessionWorkout)
        } else {
            var sessionWorkout = SessionWorkout()
            sessionWorkout.athleteId = onAthlete.id
            sessionWorkout.workoutTypeId = selectedWorkout.id
            sessionWorkout.state = .saved
            sessionWorkout.completedDate = Date()
            sessionWorkout.workoutStats = withWorkoutStats
            session?.loggedWorkouts?.append(sessionWorkout)
        }
        reloadAthleteSelector()
        self.hideForm(formToHide: self.activeForm)
    }
    
    func changesMadeToWorkout(onAthlete: Athlete) {
        if let existingSessionWorkoutIndex = session?.loggedWorkouts?.firstIndex(where: { (sessionWorkout) -> Bool in
            return sessionWorkout.athleteId == onAthlete.id && sessionWorkout.workoutTypeId == selectedWorkout.id
        }), var existingSessionWorkout = session?.loggedWorkouts?[existingSessionWorkoutIndex] {
            existingSessionWorkout.state = .editing
            session?.loggedWorkouts?.remove(at: existingSessionWorkoutIndex)
            session?.loggedWorkouts?.append(existingSessionWorkout)
        } else {
            var sessionWorkout = SessionWorkout()
            sessionWorkout.athleteId = onAthlete.id
            sessionWorkout.workoutTypeId = selectedWorkout.id
            sessionWorkout.state = .editing
            session?.loggedWorkouts?.append(sessionWorkout)
        }
        reloadAthleteSelector()
    }
    
    func removeSession(session: SessionWorkout) {
        self.session?.loggedWorkouts?.removeAll(where: { (sw) -> Bool in
            return sw.id == session.id
        })
    }
    
    func saveSession(session: SessionWorkout) {
        removeSession(session: session)
        self.session?.loggedWorkouts?.append(session)
    }
    
    private func showForm(forAthlete: Athlete?) {
        let oldForm = self.activeForm
        
        self.activeForm = WorkoutFormFactory.getForm(focusedWorkout: selectedWorkout, focusedAthlete: selectedAthlete, session: session)
        self.activeForm?.delegate = self
        
        self.addWorkoutFormToFormContainer()
        self.hideForm(formToHide: oldForm)
    }
    
    private func addWorkoutFormToFormContainer()
    {
        guard let activeForm = self.activeForm else { return }
        self.formContainer?.addSubview(activeForm)
        
        let leading = NSLayoutConstraint(item: activeForm, attribute: .leading, relatedBy: .equal, toItem: self.formContainer!, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailing = NSLayoutConstraint(item: activeForm, attribute: .trailing, relatedBy: .equal, toItem: self.formContainer!, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let top = NSLayoutConstraint(item: activeForm, attribute: .top, relatedBy: .equal, toItem: self.formContainer!, attribute: .top, multiplier: 1.0, constant: 0.0)
        let bottom = NSLayoutConstraint(item: activeForm, attribute: .bottom, relatedBy: .equal, toItem: self.formContainer!, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        
        self.formContainer?.addConstraints([leading, trailing, top, bottom])
    }
    
    private func setFullScreenFormMode(on: Bool)
    {
        self.view.removeConstraint(self.formContainerTopConstraint)
        
        self.formContainerTopConstraint = NSLayoutConstraint(item: formContainer!, attribute: .top, relatedBy: .equal, toItem: on ? self.view : self.separationView, attribute: on ? .topMargin : .bottom, multiplier: 1.0, constant: 0.0)
        
        self.view.addConstraint(self.formContainerTopConstraint)
        
        self.athleteSelectorCollectionView.isHidden = on
        self.separationView.isHidden = on
    }
    
    private func hideForm(formToHide: UIView?) {
        guard let formToHide = formToHide else { return }
        formToHide.removeFromSuperview()
    }
    
    private func reloadAthleteSelector() {
        var athletes: [(Athlete, SessionWorkout?)] = []
        for athlete in self.session?.athletes ?? [] {
            athletes.append((athlete, self.session?.loggedWorkouts?.filter({ (sessionWorkout) -> Bool in
                return sessionWorkout.workoutTypeId == self.selectedWorkout.id && sessionWorkout.athleteId == athlete.id
                }).first))
        }
        self.athleteSelectorCollectionView.athletes = athletes
        self.athleteSelectorCollectionView.reloadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    fileprivate func setupContraints() {
        var leading = NSLayoutConstraint(item: formContainer!, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0.0)
        var trailing = NSLayoutConstraint(item: formContainer!, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        self.formContainerTopConstraint = NSLayoutConstraint(item: formContainer!, attribute: .top, relatedBy: .equal, toItem: self.separationView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let bottom = NSLayoutConstraint(item: formContainer!, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottomMargin, multiplier: 1.0, constant: 0.0)
        
        self.view.addConstraints([leading, trailing, formContainerTopConstraint, bottom])
        
        let centerX = NSLayoutConstraint(item: formContainerInstructionLabel!, attribute: .centerX, relatedBy: .equal, toItem: self.formContainer, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        let centerY = NSLayoutConstraint(item: formContainerInstructionLabel!, attribute: .centerY, relatedBy: .equal, toItem: self.formContainer, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        leading = NSLayoutConstraint(item: formContainerInstructionLabel!, attribute: .leading, relatedBy: .greaterThanOrEqual, toItem: self.formContainer, attribute: .leading, multiplier: 1.0, constant: 50.0)
        trailing = NSLayoutConstraint(item: formContainerInstructionLabel!, attribute: .trailing, relatedBy: .greaterThanOrEqual, toItem: self.formContainer, attribute: .trailing, multiplier: 1.0, constant: -50.0)
        
        self.formContainer.addConstraints([centerX, centerY, leading, trailing])
    }
    
    fileprivate func setupViews() {
        self.formContainer = UIView()
        self.formContainer.backgroundColor = UIColor.TRprimary
        self.formContainer.translatesAutoresizingMaskIntoConstraints = false
        
        self.formContainerInstructionLabel = UILabel()
        self.formContainerInstructionLabel.backgroundColor = UIColor.TRprimary
        self.formContainerInstructionLabel.textColor = UIColor.TRfont
        self.formContainerInstructionLabel.text = "Next athlete select your profile to log your workout data."
        self.formContainerInstructionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.formContainerInstructionLabel.textAlignment = .center
        self.formContainerInstructionLabel.numberOfLines = 5
        self.formContainerInstructionLabel.font = UIFont(name: "Futura", size: 25.0)
        
        self.view.addSubview(formContainer)
        self.formContainer.addSubview(formContainerInstructionLabel)
    }
}
