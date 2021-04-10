//
//  FirstViewController.swift
//  trainerapp
//
//  Created by Andrew Daniels on 3/2/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import UIKit

class AttendanceViewController: UIViewController {
    
    @IBOutlet weak var currentClassTableView: AttendanceTableView!
    @IBOutlet weak var allAthletesTableView: AttendanceTableView!
    @IBOutlet weak var segmentedControlFilter: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

