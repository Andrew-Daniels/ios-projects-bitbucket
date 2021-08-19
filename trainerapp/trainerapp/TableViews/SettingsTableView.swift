//
//  SettingsTableViewController.swift
//  trainerapp
//
//  Created by Andrew Daniels on 8/8/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import UIKit

class SettingsTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    private var cellIdentifier = "SettingsCell"
    private var settings : [SettingModel]!
    
    public enum SettingsSectionEnum: Int {
        case Athlete = 0
        case AccountSettings
    }
    
    func setup() {
        self.backgroundColor = UIColor.TRprimary
        self.register(SettingsTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        settings = [
            SettingModel(name: "Switch to Athlete View", hint: "Use app as an athlete", section: "Athlete"),
            SettingModel(name: "Personal information", hint: nil, section: "Account Settings"),
            SettingModel(name: "Notifications", hint: nil, section: "Account Settings")
        ]
        
        self.delegate = self
        self.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SettingsTableViewCell
        let setting = settings[indexPath.row]
        cell.setting = setting
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Settings"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return settings.count
    }
}
