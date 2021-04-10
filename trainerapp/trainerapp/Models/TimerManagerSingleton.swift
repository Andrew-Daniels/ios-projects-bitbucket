//
//  TimerManager.swift
//  trainerapp
//
//  Created by Andrew Daniels on 3/17/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import Foundation

class TimerManagerSingleton {
    
    static let instance = TimerManagerSingleton()
    
    public var timers: [String : TimerInfo] = [:]
    
    private init() {
    }
    
    public func startTimer(with id: String) -> TimerInfo {
        let newTimer = TimerInfo(id: id)
        timers[id] = newTimer
        return newTimer
    }
    
    public func getTimer(with id: String) -> TimerInfo? {
        if timers.keys.contains(id) {
            if let timerInfo = timers[id], let timer = timerInfo.timer {
                if timer.isValid { return timerInfo }
                else { pauseTimer(with: id) }
            }
        }
        return nil
    }
    
    public func pauseTimer(with id: String) {
        if timers.keys.contains(id) {
            let timerToPause = timers[id]
            timerToPause?.delegate = nil
            timerToPause?.timer?.invalidate()
            timerToPause?.timer = nil
        }
    }
    
    class TimerInfo {
        var timer: Timer?
        var id: String!
        var secondsPassed: Int?
        var minutesPassed: Int?
        var delegate: TimerInfoDelegate?
        private var totalSecondsPassed: Int = 0
        
        init(id: String) {
            self.id = id
            DispatchQueue.global(qos: .background).async {
                self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.fire(timer:)), userInfo: nil, repeats: true)
                RunLoop.current.run()
            }
        }
        
        @objc func fire(timer: Timer)
        {
            updateTimePassed()
            guard let delegate = self.delegate else { return }
            DispatchQueue.main.async {
                delegate.timerHasChanged()
            }
        }
        
        private func updateTimePassed() {
            self.totalSecondsPassed += 1
            self.secondsPassed = self.totalSecondsPassed % 60
            self.minutesPassed = Int(roundf(Float(self.totalSecondsPassed / 60)))
        }
        
        public func resetTimer() {
            self.totalSecondsPassed = 0
            self.secondsPassed = 0
            self.minutesPassed = 0
        }
    }
}

protocol TimerInfoDelegate {
    func timerHasChanged()
}
