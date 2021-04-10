//
//  CompletionAthleteSelectorCollectionViewController.swift
//  trainerapp
//
//  Created by Andrew Daniels on 3/22/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import UIKit

protocol CompletionAthleteSelectorDelegate {
    func athleteSelected(athlete: Athlete, completionType: CompletionAthleteSelectorCollectionViewType)
}

class CompletionAthleteSelectorCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    public var type: CompletionAthleteSelectorCollectionViewType = .notComplete
    
    private var cellIdentifier = "CompletionAthleteCell"
    public var athletes: [(Athlete, SessionWorkout?)]?
    public var selectedIndex: Int?
    public var selectorDelegate: CompletionAthleteSelectorDelegate?
    
    init(with athletes: [(Athlete, SessionWorkout?)]?, type: CompletionAthleteSelectorCollectionViewType) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 0)
        super.init(frame: CGRect.zero, collectionViewLayout: layout)
        self.backgroundColor = UIColor.TRprimary
        self.type = type
        self.athletes = athletes
        
        self.register(CompletionAthleteSelectorCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = self.type == .notComplete ? UIColor.TRprimary : UIColor.TRsecondary
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.delegate = self
        self.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return athletes?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CompletionAthleteSelectorCollectionViewCell
        
        cell.athlete = athletes![indexPath.row]
        cell.setState(toState: self.type)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 60, height: 95)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let athleteSelected = athletes?[indexPath.row].0 else { return }
        self.selectorDelegate?.athleteSelected(athlete: athleteSelected, completionType: type)
    }
}
