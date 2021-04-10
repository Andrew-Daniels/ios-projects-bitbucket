//
//  SessionWorkoutSelectorTableView.swift
//  trainerapp
//
//  Created by Andrew Daniels on 3/15/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import UIKit

protocol SessionWorkoutSelectorTableViewDelegate {
    func workoutSelectionChanged(workout: WorkoutType)
}

class SessionWorkoutSelectorTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    private var cellIdentifier = "WorkoutCell"
    private var selectedWorkoutId: String!
    var workoutList: [WorkoutType]!
    var controlDelegate: SessionWorkoutSelectorTableViewDelegate?
    
    func setup() {
        self.register(SessionWorkoutSelectorTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.selectedWorkoutId = workoutList?.first?.id
        
        self.backgroundColor = UIColor.TRprimary
        self.separatorStyle = .none
        self.dataSource = self
        self.delegate = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SessionWorkoutSelectorTableViewCell
        cell.workout = workoutList[indexPath.row]
        cell.setState(state: cell.workout.id == selectedWorkoutId ? .selected : .notSelected)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let workoutSelected = workoutList[indexPath.row]
        self.selectedWorkoutId = workoutSelected.id
        self.reloadData()
        controlDelegate?.workoutSelectionChanged(workout: workoutSelected)
    }
}
