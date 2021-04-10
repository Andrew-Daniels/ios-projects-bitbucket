//
//  WorkoutFormFactory.swift
//  trainerapp
//
//  Created by Andrew Daniels on 4/8/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import Foundation

struct WorkoutFormFactory {
    
    static func getForm(focusedWorkout: WorkoutType, focusedAthlete: Athlete?, session: Session?) -> WorkoutForm? {
        var workoutFormToReturn: WorkoutForm?
        
        switch focusedWorkout.formType {
        case .SetRepWeight:
            guard let focusedAthlete = focusedAthlete else { return workoutFormToReturn }
            workoutFormToReturn = SetRepWeightForm(athlete: focusedAthlete, withWorkoutStats: session?.loggedWorkouts?.first(where: { (sessionWorkout) -> Bool in
                return sessionWorkout.athleteId == focusedAthlete.id && sessionWorkout.workoutTypeId == focusedWorkout.id
            })?.workoutStats.sorted(by: { (left, right) -> Bool in
                return left.set < right.set
            }) ?? [])
            break
        case .Distance:
            workoutFormToReturn = DistanceForm(athletes: session!.athletes!, with: session?.loggedWorkouts?.compactMap { workout in workout.workoutTypeId == focusedWorkout.id ? workout : nil } ?? [], for: focusedWorkout.id)
            break
        case .none:
            break
        }
        return workoutFormToReturn
    }
}
