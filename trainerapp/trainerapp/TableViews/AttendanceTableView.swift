//
//  AttendanceTableViewController.swift
//  trainerapp
//
//  Created by Andrew Daniels on 3/2/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import UIKit

class AttendanceTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    public var type: AttendenceTableViewType!
    private var athleteLayer: AthleteLayer!
    private var athletes: [Athlete] = []
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setup(type: AttendenceTableViewType) {
        self.type = type
        athleteLayer = EntityFactorySingleton.instance.athletes
        athleteLayer.getAll(asyncCompleteWithObjects: { (result) in
            switch result {
            case .success(let results):
                if self.type == .CurrentClass {
                    self.athletes = stride(from: 0, to: results.count, by: 2).map { results[$0] }
                }
                else {
                    self.athletes = results
                }
                break
            case .failure(let err):
                print(err)
                break
            }
        })
        self.delegate = self
        self.dataSource = self
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return athletes.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: type!), for: indexPath) as! AttendanceTableViewCell
        cell.athlete = athletes[indexPath.row]
        cell.type = type
        return cell
    }
}
