//
//  SomeStoreLayer.swift
//  trainerapp
//
//  Created by Andrew Daniels on 3/2/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import Foundation

class SomeStoreLayer<T: SomeCodable, Keys: CodingKey> {
    
    public var athletes: [Athlete]!
    public var session: Session!
    public var workoutTypes: [WorkoutType]!
    public var workout: SessionWorkout!
    public var trainer: Trainer!
    
    public var basePath: Path!

    init() {
        self.basePath = Path()
        
        athletes = [
            Athlete(firstName: "Channing", lastName: "Tatum"),
            Athlete(firstName: "Andrew", lastName: "Daniels"),
            Athlete(firstName: "Jaswinder", lastName: "Singh"),
            Athlete(firstName: "Chase", lastName: "Struse"),
            Athlete(firstName: "Brad", lastName: "Pitt"),
            Athlete(firstName: "Selena", lastName: "Gomez"),
            Athlete(firstName: "Mike", lastName: "WillMadeIt"),
            Athlete(firstName: "Hannibal", lastName: "Lector"),
            Athlete(firstName: "Tom", lastName: "Brady")
        ]
        trainer = Trainer()
        trainer.id = UUID().uuidString
        trainer.firstName = "Andre"
        trainer.lastName = "Giant"
        
        var workoutType1 = WorkoutType()
        workoutType1.id = UUID().uuidString
        workoutType1.formType = .SetRepWeight
        workoutType1.title = "Bicep Curls"
        
        var workoutType2 = WorkoutType()
        workoutType2.id = UUID().uuidString
        workoutType2.formType = .SetRepWeight
        workoutType2.title = "Deadlifts"
        
        var workoutType3 = WorkoutType()
        workoutType3.id = UUID().uuidString
        workoutType3.formType = .Distance
        workoutType3.title = "1 Mile"
        
        var workoutType4 = WorkoutType()
        workoutType4.id = UUID().uuidString
        workoutType4.formType = .Distance
        workoutType4.title = "5 Miles"
        
        var workoutType5 = WorkoutType()
        workoutType5.id = UUID().uuidString
        workoutType5.formType = .SetRepWeight
        workoutType5.title = "Tricep Extensions"
        
        var workoutType6 = WorkoutType()
        workoutType6.id = UUID().uuidString
        workoutType6.formType = .SetRepWeight
        workoutType6.title = "Squats"
        
        workoutTypes = [workoutType1, workoutType2, workoutType3, workoutType4, workoutType5, workoutType6]
        
        var workoutStat = WorkoutStat()
        workoutStat.weight = 15
        workoutStat.reps = 10
        workoutStat.set = 1
        workoutStat.id = UUID().uuidString
        var workoutStat2 = WorkoutStat()
        workoutStat2.weight = 15
        workoutStat2.reps = 10
        workoutStat2.set = 2
        workoutStat2.id = UUID().uuidString
        workout = SessionWorkout()
        workout.id = UUID().uuidString
        workout.athleteId = "AndrewDaniels"
        workout.workoutTypeId = workoutType1.id
        workout.workoutStats = [workoutStat, workoutStat2]
        workout.state = .saved
        
        session = Session()
        session.id = UUID().uuidString
        session.athletes = athletes
        session.loggedWorkouts = []
        session.status = .Started
        session.scheduledDate = Date()
        session.workouts = workoutTypes
        session.trainers = [trainer]
    }
    
    convenience init(parentPath: String, forKey: CodingKey) {
        self.init()
        self.basePath.value = "\(parentPath)/\(forKey.stringValue)/{id}"
    }
    
    func getChildLayer<ChildType: SomeCodable, ChildKeys: CodingKey>(forObj: T, forKey: Keys) -> SomeStoreLayer<ChildType, ChildKeys> {
        return SomeStoreLayer<ChildType, ChildKeys>(parentPath: self.basePath.build(with: forObj.id), forKey: forKey)
    }
    
    /// Gets the object by it's id.
    /// - Parameters:
    ///   - id: The identification number of the object
    ///   - asyncCompleteWithObject: Returns the object or nil if it doesn't exist
    public func getBy(id: String, asyncCompleteWithObject: @escaping (Result<T, Error>) -> Void) {
        if (T() is Trainer) {
            asyncCompleteWithObject(.success(trainer as! T))
        }
    }
    
    /// Gets all documents within a collection
    /// - Parameter asyncCompleteWithObjects: Contains the objects or error if objects could not be found
    func getAll(asyncCompleteWithObjects: @escaping (Result<[T], Error>) -> Void) {
        if (T() is Athlete) {
            asyncCompleteWithObjects(.success(athletes as! [T]))
        }
        if (T() is Session) {
            asyncCompleteWithObjects(.success([session] as! [T]))
        }
    }
    
    /// Gets all objects that match the id's supplied
    /// - Parameters:
    ///   - ids: id's of the objects to be retrieved
    ///   - asyncCompleteWithObjects: Contains the objects or error if objects could not be found
    func getAllBy(ids: [String], asyncCompleteWithObjects: @escaping ([Result<T, Error>]) -> Void) {
        var returnValue = [Result<T, Error>]()
        for _ in 0...5 {
            returnValue.append(.success(T()))
        }
        asyncCompleteWithObjects(returnValue)
    }
    
    /// Get the object by it's id, with index tracking
    /// - Parameters:
    ///   - id: id of the object to be retrieved
    ///   - forIndex: the index of the object in a list of objects that are being retrieved
    ///   - asyncCompleteWithObject: Contains the object or error if the object could not be found
    func getBy(id: String, forIndex: Int, asyncCompleteWithObject: @escaping (Result<T, Error>, Int) -> Void) {
        self.getBy(id: basePath.build(with: id)) { (result) in
            asyncCompleteWithObject(result, forIndex)
        }
    }
}
