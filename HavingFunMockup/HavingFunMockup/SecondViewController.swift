//
//  SecondViewController.swift
//  HavingFunMockup
//
//  Created by Andrew Daniels on 2/2/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIScrollViewDelegate {
    
    
    @IBOutlet weak var optionsView: UIScrollView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var initialsLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    var dictOfWorkouts = ["Push Ups": ["All", "Chest"], "Squats":["All", "Legs"], "1 Mile":["All", "Cardio"], "2 Miles":["All", "Cardio"], "Dead Lifts":["All", "Back"]]
    var components = ["All", "Legs", "Cardio", "Chest", "Back"]
    var name = ""
    var initials = ""
    var profileImage: UIImage?
    var profilePicture: ProfilePicture?
    
    //MARK: - UIPickerViewDelegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        let comp = components.sorted()[selectedRow]
        return filterWorkouts(comp: comp)
    }
    
    func filterWorkouts(comp: String) -> Int {
        let filteredWorkouts = dictOfWorkouts.filter({ (key, value) -> Bool in
            for item in value {
                let match = item.lowercased().range(of: comp.lowercased())
                let isTrue = match != nil ? true : false
                if isTrue == true {
                    return true
                }
            }
            return false
        })
        return filteredWorkouts.count
    }
    
    func filterWorkouts(comp: String, row: Int) -> String? {
        let filteredWorkouts = dictOfWorkouts.filter { (key, value) -> Bool in
            for item in value {
                let match = item.lowercased().range(of: comp.lowercased())
                let isTrue = match != nil ? true : false
                if isTrue == true {
                    return true
                }
            }
            return false
        }
        let array = Array(filteredWorkouts.keys).sorted()
        if array.count > row {
            return array[row]
        }
        let string: String? = nil
        return string
    }
    
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        var string = ""
        if component == 0 {
            string = components.sorted()[row]
            return NSAttributedString(string: string, attributes: [NSAttributedStringKey.foregroundColor:UIColor.white])
        } else {
            if let newString = filterWorkouts(comp: components.sorted()[pickerView.selectedRow(inComponent: 0)], row: row) {
                string = newString
                return NSAttributedString(string: string, attributes: [NSAttributedStringKey.foregroundColor:UIColor.white])
            }
        }
        let blank: NSAttributedString? = nil
        return blank
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            pickerView.reloadComponent(1)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let profilePicture = profilePicture {
            setProfilePicture(pp: profilePicture)
        }
        self.navigationItem.title = name
        profileImageView.layer.masksToBounds = true
        // Do any additional setup after loading the view.
        let view2 = Push_Ups.instanceFromNib()
        self.optionsView.addSubview(view2)
        optionsView.contentSize = CGSize(width: optionsView.frame.width, height: view2.frame.height)
    }
    
    func setProfilePicture(pp: ProfilePicture) {
        profileImageView.image = pp.image
        initialsLabel.isHidden = pp.initialsHidden
        initialsLabel.text = pp.initials
        profileImageView.layer.cornerRadius = CGFloat(pp.radius)
        profileImageView.layer.borderColor = pp.borderColor
        profileImageView.layer.borderWidth = CGFloat(pp.borderWidth)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UIScrollViewDelegate
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
