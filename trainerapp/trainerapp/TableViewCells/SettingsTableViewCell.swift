//
//  SettingsTableViewCell.swift
//  trainerapp
//
//  Created by Andrew Daniels on 8/8/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    private var primaryLbl: UILabel!
    private var secondaryLbl: UILabel!
    private var iconImageView: UIImageView!
    public var setting: SettingModel! {
        didSet {
            self.primaryLbl.text = setting.name
            self.secondaryLbl.text = setting.hint
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupViews() {
        self.backgroundColor = UIColor.TRprimary
        
        self.primaryLbl = UILabel()
        self.primaryLbl.translatesAutoresizingMaskIntoConstraints = false
        self.primaryLbl.font = UIFont(name: "Futura", size: 18)
        self.secondaryLbl = UILabel()
        self.secondaryLbl.translatesAutoresizingMaskIntoConstraints = false
        self.secondaryLbl.font = UIFont(name: "Futura", size: 10)
        self.iconImageView = UIImageView()
        
    }
    
    private func setupConstraints() {
        self.addSubview(primaryLbl)
        self.addSubview(secondaryLbl)
        self.addSubview(iconImageView)
        
        NSLayoutConstraint.activate([
            primaryLbl.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            primaryLbl.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
            secondaryLbl.leadingAnchor.constraint(equalTo: self.primaryLbl.leadingAnchor, constant: 0),
            secondaryLbl.topAnchor.constraint(equalTo: self.primaryLbl.bottomAnchor, constant: 5)
        ])
    }

}
