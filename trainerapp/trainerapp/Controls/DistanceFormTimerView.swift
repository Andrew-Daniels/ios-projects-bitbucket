//
//  DistanceFormTimerView.swift
//  trainerapp
//
//  Created by Andrew Daniels on 4/2/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import UIKit

protocol DistanceFormTimerViewDelegate {
    func timerStarted()
    func timerStopped()
}

class DistanceFormTimerView: UIView {
    
    var timerView: TimerView!
    var delegate: DistanceFormTimerViewDelegate? {
        didSet {
            timerView.isTimerRunning() ? delegate?.timerStarted() : delegate?.timerStopped()
        }
    }
    
    private var startClockBtn: UIButton!
    private var startClockUnderView: UIImageView!
    private var stopClockBtn: UIButton!
    
    private var workoutTypeId: String!
    
    init(with workoutTypeId: String) {
        super.init(frame: CGRect.zero)
        self.workoutTypeId = workoutTypeId
        setupViews()
        setupConstraints()
        
        startClockBtn.addTarget(self, action: #selector(startClockBtnClicked), for: .touchUpInside)
        stopClockBtn.addTarget(self, action: #selector(stopClockBtnClicked), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupViews() {
        self.backgroundColor = UIColor.TRprimary
        startClockBtn = UIButton()
        startClockBtn.translatesAutoresizingMaskIntoConstraints = false
        startClockBtn.setTitle("Start Clock", for: .normal)
        startClockBtn.setTitleColor(UIColor.TRfont, for: .normal)
        startClockBtn.setTitleColor(UIColor.TRsecondary, for: .highlighted)
        startClockBtn.titleLabel?.font = UIFont(name: "Futura", size: 25)
        
        startClockUnderView = UIImageView()
        startClockUnderView.translatesAutoresizingMaskIntoConstraints = false
        startClockUnderView.image = UIImage(named: "UnderAction")?.withRenderingMode(.alwaysTemplate)
        startClockUnderView.tintColor = UIColor.TRfont
            
        timerView = TimerView(with: workoutTypeId)
        timerView.translatesAutoresizingMaskIntoConstraints = false
        
        stopClockBtn = UIButton()
        stopClockBtn.translatesAutoresizingMaskIntoConstraints = false
        stopClockBtn.setTitle("Stop", for: .normal)
        stopClockBtn.setTitleColor(UIColor.TRred, for: .normal)
        stopClockBtn.setTitleColor(UIColor.TRsecondary, for: .highlighted)
        stopClockBtn.titleLabel?.font = UIFont(name: "Futura", size: 25)
        
        startClockUnderView.isHidden = timerView.isTimerRunning()
        startClockBtn.isHidden = timerView.isTimerRunning()
        stopClockBtn.isHidden = !timerView.isTimerRunning()
    }
    
    func setupConstraints() {
        self.addSubview(startClockBtn)
        self.addSubview(startClockUnderView)
        self.addSubview(stopClockBtn)
        self.addSubview(timerView)
        
        NSLayoutConstraint.activate([
            startClockBtn.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            startClockBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -70),
            
            stopClockBtn.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            stopClockBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -70),
            
            startClockUnderView.topAnchor.constraint(equalTo: startClockBtn.bottomAnchor, constant: 0),
            startClockUnderView.trailingAnchor.constraint(equalTo: startClockBtn.trailingAnchor, constant: -10),
            
            timerView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            timerView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -85)
        ])
    }
    
    @objc func startClockBtnClicked(_ sender: UIButton) {
        self.timerView.startTimer()
        Animator.animate(animations: [
            Animation(view: self.startClockBtn, type: .ShrinkFadeOut),
            Animation(view: self.startClockUnderView, type: .ShrinkFadeOut),
            Animation(view: self.stopClockBtn, type: .ShrinkFadeIn)
        ])
        self.delegate?.timerStarted()
    }
    
    @objc func stopClockBtnClicked(_ sender: UIButton) {
        self.timerView.stopTimer()
        Animator.animate(animations: [
            Animation(view: self.stopClockBtn, type: .ShrinkFadeOut),
            Animation(view: self.startClockBtn, type: .ShrinkFadeIn),
            Animation(view: self.startClockUnderView, type: .ShrinkFadeIn)
        ])
        self.delegate?.timerStopped()
    }
}
