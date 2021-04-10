//
//  TimerControl.swift
//  trainerapp
//
//  Created by Andrew Daniels on 3/21/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import UIKit

class TimerView: UIView, TimerInfoDelegate {
    
    public var timer: TimerManagerSingleton.TimerInfo?
    private var actualMinutesLabel: UILabel!
    private var clockColonLabel: UILabel!
    private var minLabel: UILabel!
    private var actualSecondsLabel: UILabel!
    private var secLabel: UILabel!

    public var timerColor: UIColor! {
        didSet {
            self.actualMinutesLabel.textColor = self.timerColor
            self.actualSecondsLabel.textColor = self.timerColor
            self.clockColonLabel.textColor = self.timerColor
        }
    }
    
    func timerHasChanged() {
        let minutesPassedString = (self.timer?.minutesPassed ?? 0) < 10 ? "0\(self.timer?.minutesPassed ?? 0)" : "\(self.timer?.minutesPassed ?? 0)"
        let secondsPassedString = (self.timer?.secondsPassed ?? 0) < 10 ? "0\(self.timer?.secondsPassed ?? 0)" : "\(self.timer?.secondsPassed ?? 0)"
        self.actualMinutesLabel.text = minutesPassedString
        self.actualSecondsLabel.text = secondsPassedString
    }
    
    private func initControl() {
        if timer == nil {
            let timerManager = TimerManagerSingleton.instance
            self.timer = timerManager.getTimer(with: "testId") == nil ? timerManager.startTimer(with: "testId") : timerManager.getTimer(with: "testId")
            self.timer?.delegate = self
        }
        
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        actualMinutesLabel = UILabel()
        actualMinutesLabel.translatesAutoresizingMaskIntoConstraints = false
        actualMinutesLabel.text = "00"
        actualMinutesLabel.font = UIFont(name: "Futura", size: 50)
        actualMinutesLabel.textColor = UIColor.TRred
        actualMinutesLabel.textAlignment = .center
        
        clockColonLabel = UILabel()
        clockColonLabel.translatesAutoresizingMaskIntoConstraints = false
        clockColonLabel.text = ":"
        clockColonLabel.font = UIFont(name: "Futura", size: 50)
        clockColonLabel.textColor = UIColor.TRred
        clockColonLabel.textAlignment = .center
        
        actualSecondsLabel = UILabel()
        actualSecondsLabel.translatesAutoresizingMaskIntoConstraints = false
        actualSecondsLabel.text = "00"
        actualSecondsLabel.font = UIFont(name: "Futura", size: 50)
        actualSecondsLabel.textColor = UIColor.TRred
        actualSecondsLabel.textAlignment = .center
        
        minLabel = UILabel()
        minLabel.translatesAutoresizingMaskIntoConstraints = false
        minLabel.text = "min"
        minLabel.font = UIFont(name: "Futura", size: 15)
        minLabel.textColor = UIColor.TRfont
        minLabel.textAlignment = .right
        
        secLabel = UILabel()
        secLabel.translatesAutoresizingMaskIntoConstraints = false
        secLabel.text = "sec"
        secLabel.font = UIFont(name: "Futura", size: 15)
        secLabel.textColor = UIColor.TRfont
        secLabel.textAlignment = .right
    }
    
    private func setupConstraints() {
        self.addSubview(actualMinutesLabel)
        self.addSubview(clockColonLabel)
        self.addSubview(actualSecondsLabel)
        self.addSubview(secLabel)
        self.addSubview(minLabel)
        
        let centerX = NSLayoutConstraint(item: clockColonLabel!, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        var centerY = NSLayoutConstraint(item: clockColonLabel!, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        
        self.addConstraints([centerX, centerY])
        
        centerY = NSLayoutConstraint(item: actualMinutesLabel!, attribute: .centerY, relatedBy: .equal, toItem: clockColonLabel!, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        var trailing = NSLayoutConstraint(item: actualMinutesLabel!, attribute: .trailing, relatedBy: .equal, toItem: clockColonLabel!, attribute: .leading, multiplier: 1.0, constant: -2.0)
        
        self.addConstraints([centerY, trailing])
        
        centerY = NSLayoutConstraint(item: actualSecondsLabel!, attribute: .centerY, relatedBy: .equal, toItem: clockColonLabel!, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let leading = NSLayoutConstraint(item: actualSecondsLabel!, attribute: .leading, relatedBy: .equal, toItem: clockColonLabel!, attribute: .trailing, multiplier: 1.0, constant: 2.0)
        
        self.addConstraints([centerY, leading])
        
        var top = NSLayoutConstraint(item: secLabel!, attribute: .top, relatedBy: .equal, toItem: actualSecondsLabel!, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        trailing = NSLayoutConstraint(item: secLabel!, attribute: .trailing, relatedBy: .equal, toItem: actualSecondsLabel!, attribute: .trailing, multiplier: 1.0, constant: -1.0)
        
        self.addConstraints([top, trailing])
        
        top = NSLayoutConstraint(item: minLabel!, attribute: .top, relatedBy: .equal, toItem: actualMinutesLabel!, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        trailing = NSLayoutConstraint(item: minLabel!, attribute: .trailing, relatedBy: .equal, toItem: actualMinutesLabel!, attribute: .trailing, multiplier: 1.0, constant: 1.0)
        
        self.addConstraints([top, trailing])
    }
}
