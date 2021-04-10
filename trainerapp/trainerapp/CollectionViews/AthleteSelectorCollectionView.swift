//
//  AthleteSelectorCollectionView.swift
//  trainerapp
//
//  Created by Andrew Daniels on 3/4/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import UIKit

protocol AthleteSelectorDelegate {
    func athleteSelected(athlete: Athlete)
}

class AthleteSelectorCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    public var selectorDelegate: AthleteSelectorDelegate?
    
    private var cellIdentifier = "Athlete"
    public var athletes: [(Athlete, SessionWorkout?)]?
    public var selectedIndex: Int?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.delegate = self
        self.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return athletes?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! AthleteSelectorCollectionViewCell
        
        cell.athlete = athletes![indexPath.row].0
        let sessionWorkout = athletes![indexPath.row].1
        
        cell.setState(toState: sessionWorkout?.state == .editing ? .unsaved : sessionWorkout?.workoutStats?.count ?? 0 > 0 ? .saved : .none)
        cell.setState(toState: self.selectedIndex != nil && self.selectedIndex == indexPath.row ? .selected : .deselected)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectorDelegate?.athleteSelected(athlete: athletes![indexPath.row].0)
        selectedIndex = indexPath.row
        collectionView.reloadData()
    }
}
