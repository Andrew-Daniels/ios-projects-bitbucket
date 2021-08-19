//
//  SettingsViewController.swift
//  trainerapp
//
//  Created by Andrew Daniels on 8/8/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private var settingsTableView: SettingsTableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    fileprivate func setupViews() {
        
        self.settingsTableView = SettingsTableView()
        self.settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        self.settingsTableView.setup()
        
    }
    
    fileprivate func setupConstraints() {
        self.view.addSubview(settingsTableView)
        
        NSLayoutConstraint.activate([
            settingsTableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            settingsTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
            settingsTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            settingsTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
        ])
    }
}
