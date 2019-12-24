//
//  DateExtensions.swift
//  PickupGames
//
//  Created by Andrew Daniels on 11/11/19.
//  Copyright © 2019 Andrew Daniels. All rights reserved.
//

import Foundation

extension Date {
    func convertToTimeZone(initTimeZone: TimeZone, timeZone: TimeZone) -> Date {
         let delta = TimeInterval(timeZone.secondsFromGMT() - initTimeZone.secondsFromGMT())
         return addingTimeInterval(delta)
    }
    func toLocal() -> Date {
        let delta = TimeInterval(TimeZone.current.secondsFromGMT())
        return addingTimeInterval(delta)
    }
    
    func toUTC() -> Date {
        let delta = TimeInterval(TimeZone.current.secondsFromGMT() * -1)
        return addingTimeInterval(delta)
    }
    
    static func from(firebase value: Double) -> Date? {
        var date: Date?
        let timeInterval = TimeInterval(value)
        date = Date(timeIntervalSince1970: timeInterval / 1000)
        return date
    }
}
