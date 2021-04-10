//
//  FirstViewController.swift
//  trainerapp
//
//  Created by Andrew Daniels on 3/2/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import UIKit

class AttendanceViewController: UIViewController, ProfileSettingsSelectorDelegate {
    
    @IBOutlet weak var currentClassTableView: AttendanceTableView!
    @IBOutlet weak var allAthletesTableView: AttendanceTableView!
    @IBOutlet weak var segmentedControlFilter: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EntityFactorySingleton.instance.trainers.getBy(id: "", asyncCompleteWithObject: { (result) in
            switch (result) {
            case .success(let trainer):
                let profileSettingsSelectorView = ProfileSettingsSelectorView(trainer: trainer, superview: self.view)
                profileSettingsSelectorView.delegate = self
                self.navigationItem.titleView = profileSettingsSelectorView
                break
            case .failure(let err):
                print(err)
                break
            }
        })
        
        currentClassTableView.setup(type: .CurrentClass)
        allAthletesTableView.setup(type: .All)
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: Any) {
        let selectedIndex = (sender as! UISegmentedControl).selectedSegmentIndex
        if selectedIndex == 0 {
            currentClassTableView.isHidden = false
            allAthletesTableView.isHidden = true
        }
        else {
            currentClassTableView.isHidden = true
            allAthletesTableView.isHidden = false
        }
    }
}

