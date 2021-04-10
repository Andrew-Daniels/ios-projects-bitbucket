//
//  SetRepWeightTableView.swift
//  trainerapp
//
//  Created by Andrew Daniels on 3/11/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import UIKit

protocol SetRepWeightTableViewDelegate {
    func addSet(set: WorkoutStat)
    func toolbarSaveClicked()
    func toolbarUndoClicked()
}

class SetRepWeightTableView: UITableView, UITableViewDelegate, UITableViewDataSource, SetRepWeightTableViewCellDelegate {
    
    private var cellIdentifier = "SetRepWeightCell"
    var workoutStats: [WorkoutStat]!
    var controlDelegate: SetRepWeightTableViewDelegate?
    
    init() {
        super.init(frame: CGRect.zero, style: .plain)
        self.separatorStyle = .none
        self.backgroundColor = UIColor.TRprimary
        self.delegate = self
        self.dataSource = self
        self.register(SetRepWeightTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.keyboardDismissMode = .onDrag
        self.delaysContentTouches = false
        self.showsVerticalScrollIndicator = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutStats?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! SetRepWeightTableViewCell
        cell.workoutStat = workoutStats?[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func addSet() {
        var newSet = WorkoutStat()
        newSet.set = (workoutStats?.count ?? 0) + 1
        newSet.reps = workoutStats?.last?.reps ?? 10
        newSet.weight = workoutStats?.last?.weight ?? 10
        newSet.id = UUID().uuidString
        workoutStats.append(newSet)
        let indexPath = IndexPath(row: workoutStats.count - 1, section: 0)
        self.insertRows(at: [indexPath], with: .bottom)
        self.controlDelegate?.addSet(set: newSet)
        guard let newCell = self.cellForRow(at: indexPath) as? SetRepWeightTableViewCell else { return }
        newCell.focus()
    }
    
    func workoutStatDidChange(workoutStat: WorkoutStat) {
        self.workoutStats.removeAll { (ws) -> Bool in
            return ws.id == workoutStat.id
        }
        self.workoutStats.insert(workoutStat, at: workoutStat.set - 1)
        self.controlDelegate?.addSet(set: workoutStat)
    }
    
    func toolbarSaveClicked() {
        controlDelegate?.toolbarSaveClicked()
    }
    
    func toolbarUndoClicked() {
        controlDelegate?.toolbarUndoClicked()
    }
    
    func toolbarAddSetClicked() {
        addSet()
    }
}
