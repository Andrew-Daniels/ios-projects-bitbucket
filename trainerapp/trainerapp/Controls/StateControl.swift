//
//  StateControl.swift
//  trainerapp
//
//  Created by Andrew Daniels on 3/2/21.
//  Copyright © 2021 Andrew Daniels. All rights reserved.
//

import UIKit

protocol StateControlDelegate {
    func selectedChanged(sender: StateControl)
}

class StateControl: UIControl {
    
    private var checkBtn: UIButton!
    private var removeBtn: UIButton!
    private var checkedBtn: UIButton!
    private var removedBtn: UIButton!
    private var backView: UIView!
    
    public enum State {
        case None
        case Added
        case Removed
    }
    
    var controlState = State.None
    var delegate: StateControlDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initControl()
    }
    
    func stateIsSelected() -> Bool {
        return controlState != .None
    }
    
    @objc func buttonClicked(_ sender: UIButton) {
        
        switch (sender.tag) {
        case 0:
            checkedBtn.isHidden = false
            checkBtn.isHidden = true
            removeBtn.isHidden = true
            removedBtn.isHidden = true
            controlState = .Added
            break
        case 1:
            checkedBtn.isHidden = true
            checkBtn.isHidden = true
            removeBtn.isHidden = true
            removedBtn.isHidden = false
            controlState = .Removed
            break
        case 2, 3:
            checkedBtn.isHidden = true
            checkBtn.isHidden = false
            removeBtn.isHidden = false
            removedBtn.isHidden = true
            controlState = .None
            break
        default:
            return
        }
    }
    
    private func initControl() {
        
        setupViews()
        
        self.backgroundColor = .clear
        
        checkBtn.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        removeBtn.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        checkedBtn.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        removedBtn.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
        setupConstraints()
    }
    
    private func setupViews() {
        var btn = UIButton()
        var image = UIImage(named: "Checkmark_Open")?.withRenderingMode(.alwaysTemplate)
        btn.setImage(image, for: .normal)
        btn.tintColor = UIColor.TRblue
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tag = 0
        
        checkBtn = btn
        
        btn = UIButton()
        image = UIImage(named: "Remove_Open")?.withRenderingMode(.alwaysTemplate)
        btn.setImage(image, for: .normal)
        btn.tintColor = UIColor.TRred
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tag = 1
        
        removeBtn = btn
        
        btn = UIButton()
        image = UIImage(named: "Checkmark_Filled")?.withRenderingMode(.alwaysTemplate)
        btn.setImage(image, for: .normal)
        btn.tintColor = UIColor.TRblue
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tag = 2
        btn.isHidden = true
        
        checkedBtn = btn
        
        btn = UIButton()
        image = UIImage(named: "Remove_Filled")?.withRenderingMode(.alwaysTemplate)
        btn.setImage(image, for: .normal)
        btn.tintColor = UIColor.TRred
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tag = 3
        btn.isHidden = true
        
        removedBtn = btn
        
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .clear
        
        backView = v
    }

    private func setupConstraints() {
        
        backView.addSubview(checkBtn)
        backView.addSubview(removeBtn)
        backView.addSubview(checkedBtn)
        backView.addSubview(removedBtn)
        
        var centerX = NSLayoutConstraint(item: checkBtn!, attribute: .centerX, relatedBy: .equal, toItem: backView, attribute: .centerX, multiplier: 1.0, constant: 22.5)
        var centerY = NSLayoutConstraint(item: checkBtn!, attribute: .centerY, relatedBy: .equal, toItem: backView, attribute: .centerY, multiplier: 1.0, constant: 1.0)
        var height = NSLayoutConstraint(item: checkBtn!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 44.0)
        var width = NSLayoutConstraint(item: checkBtn!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 44.0)
        
        backView.addConstraints([centerX, centerY, height, width])
        
        centerX = NSLayoutConstraint(item: removeBtn!, attribute: .centerX, relatedBy: .equal, toItem: backView, attribute: .centerX, multiplier: 1.0, constant: -22.5)
        centerY = NSLayoutConstraint(item: removeBtn!, attribute: .centerY, relatedBy: .equal, toItem: backView, attribute: .centerY, multiplier: 1.0, constant: 1.0)
        height = NSLayoutConstraint(item: removeBtn!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 44.0)
        width = NSLayoutConstraint(item: removeBtn!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 44.0)
        
        backView.addConstraints([centerX, centerY, height, width])
        
        centerX = NSLayoutConstraint(item: removedBtn!, attribute: .centerX, relatedBy: .equal, toItem: backView, attribute: .centerX, multiplier: 1.0, constant: 1.0)
        centerY = NSLayoutConstraint(item: removedBtn!, attribute: .centerY, relatedBy: .equal, toItem: backView, attribute: .centerY, multiplier: 1.0, constant: 1.0)
        height = NSLayoutConstraint(item: removedBtn!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 44.0)
        width = NSLayoutConstraint(item: removedBtn!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 44.0)
        
        backView.addConstraints([centerX, centerY, height, width])
        
        centerX = NSLayoutConstraint(item: checkedBtn!, attribute: .centerX, relatedBy: .equal, toItem: backView, attribute: .centerX, multiplier: 1.0, constant: 1.0)
        centerY = NSLayoutConstraint(item: checkedBtn!, attribute: .centerY, relatedBy: .equal, toItem: backView, attribute: .centerY, multiplier: 1.0, constant: 1.0)
        height = NSLayoutConstraint(item: checkedBtn!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 44.0)
        width = NSLayoutConstraint(item: checkedBtn!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 44.0)
        
        backView.addConstraints([centerX, centerY, height, width])
        
        self.addSubview(backView)
        
        let trailing = NSLayoutConstraint(item: backView!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 1.0)
        let leading = NSLayoutConstraint(item: backView!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 1.0)
        let top = NSLayoutConstraint(item: backView!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 1.0)
        let bottom = NSLayoutConstraint(item: backView!, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 1.0)
        
        self.addConstraints([trailing, leading, top, bottom])
    }
    
}
