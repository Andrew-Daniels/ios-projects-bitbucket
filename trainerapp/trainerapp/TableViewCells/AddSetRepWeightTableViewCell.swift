//
//  AddSetRepWeightTableViewCell.swift
//  trainerapp
//
//  Created by Andrew Daniels on 3/13/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import UIKit

protocol AddSetRepWeightTableViewCellDelegate {
    func addSet()
}

class AddSetRepWeightTableViewCell: UITableViewCell {
    
    private var addSetBtn: UIButton!
    public var delegate: AddSetRepWeightTableViewCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
        self.setupContraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc func addSetBtnClicked(_ sender: UIButton) {
        delegate?.addSet()
    }
    
    private func setupViews() {
        self.backgroundColor = UIColor.TRprimary
        self.selectionStyle = .none
        addSetBtn = UIButton()
        addSetBtn.setTitle("Add a Set", for: .normal)
        addSetBtn.setTitleColor(UIColor.TRfont, for: .normal)
        addSetBtn.setTitleColor(UIColor.TRsecondary, for: .highlighted)
        addSetBtn.titleLabel?.font = UIFont(name: "Futura", size: 16.0)
        addSetBtn.translatesAutoresizingMaskIntoConstraints = false
        
        addSetBtn.addTarget(self, action: #selector(addSetBtnClicked), for: .touchUpInside)
    }
    
    private func setupContraints() {
        self.contentView.addSubview(addSetBtn)
        
        let top = NSLayoutConstraint(item: addSetBtn!, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .top, multiplier: 1.0, constant: 15.0)
        let bottom = NSLayoutConstraint(item: addSetBtn!, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let leading = NSLayoutConstraint(item: addSetBtn!, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailing = NSLayoutConstraint(item: addSetBtn!, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        
        self.contentView.addConstraints([top, bottom, leading, trailing])
    }

}
