//
//  SecondViewController.swift
//  HavingFunMockup
//
//  Created by Andrew Daniels on 2/2/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var setTableView: UITableView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var initialsLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    var dictOfWorkouts = ["Push Ups": ["All", "Chest"], "Squats":["All", "Legs"], "1 Mile":["All", "Cardio"], "2 Miles":["All", "Cardio"], "Dead Lifts":["All", "Back"]]
    var components = ["All", "Legs", "Cardio", "Chest", "Back"]
    var name = ""
    var profilePicture: ProfilePicture?
    var sets = 0
    var firstTextField: UITextField?
    var isSaved = false
    var isSavedRowVisible = false
    var defaultRep = 10
    var workoutLabel = [UILabel]()
    var repTextFields = [UITextField]()
    var cells = [TableViewCell]()
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.8, animations: {
            cell.contentView.alpha = 1.0
        })
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        sets = sets - 1
        tableView.deleteRows(at: [indexPath], with: .left)
        var newIndexPath = IndexPath(row: indexPath.row, section: 0)
        while tableView.cellForRow(at: newIndexPath) != nil {
            if tableView.cellForRow(at: newIndexPath)?.reuseIdentifier == "Cell" {
                let cell = tableView.cellForRow(at: newIndexPath) as! TableViewCell
                cell.setNumberLabel.text = String(newIndexPath.row + 1)
            }
            newIndexPath.row += 1
        }
        cells.remove(at: indexPath.row)
    }
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        if let firstTextField = firstTextField {
            firstTextField.resignFirstResponder()
        }
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if !isSaved {
            if tableView.cellForRow(at: indexPath)?.reuseIdentifier != "AddSetCell",
                tableView.cellForRow(at: indexPath)?.reuseIdentifier != "Saved"{
                return true
            }
        }
        return false
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sets + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isSaved {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Saved", for: indexPath) as! TableViewCell
            isSavedRowVisible = true
            return cell
        }
        
        if indexPath.row == sets {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddSetCell", for: indexPath) as! TableViewCell
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.setNumberLabel.text = String(indexPath.row + 1)
        firstTextField = cell.repTextfield
        cell.repTextfield.text = String(defaultRep)
        cell.workoutName.text = filterWorkouts(comp: components.sorted()[pickerView.selectedRow(inComponent: 0)], row: pickerView.selectedRow(inComponent: 1))
        workoutLabel.append(cell.workoutName)
        if !cells.contains(cell) {
            cells.append(cell)
        }
        cell.contentView.alpha = 0
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomHeader") as! CustomTableViewHeader
        return header
    }
    
    
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
            return NSAttributedString(string: string, attributes: [NSAttributedStringKey.foregroundColor:UIColor.black])
        } else {
            if let newString = filterWorkouts(comp: components.sorted()[pickerView.selectedRow(inComponent: 0)], row: row) {
                string = newString
                return NSAttributedString(string: string, attributes: [NSAttributedStringKey.foregroundColor:UIColor.black])
            }
        }
        let blank: NSAttributedString? = nil
        return blank
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            pickerView.reloadComponent(1)
        }
        if !isSaved {
            for label in workoutLabel {
                label.text = filterWorkouts(comp: components.sorted()[pickerView.selectedRow(inComponent: 0)], row: pickerView.selectedRow(inComponent: 1))
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let profilePicture = profilePicture {
            setProfilePicture(pp: profilePicture)
            self.name = profilePicture.name
        }
        self.navigationItem.title = name
        setTableView.layer.cornerRadius = 10
        setTableView.register(UINib(nibName: "CustomHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "CustomHeader")
        
        // Do any additional setup after loading the view.
    }
    @IBAction func addSetToTableView(_ sender: UIButton) {
        if !isSavedRowVisible {
            let path = IndexPath(row: sets, section: 0)
            sets = sets + 1
            setTableView.insertRows(at: [path], with: .right)
            firstTextField?.becomeFirstResponder()
            firstTextField?.selectAll(nil)
        }
    }
    
    func setProfilePicture(pp: ProfilePicture) {
        profileImageView.image = pp.image
        initialsLabel.isHidden = pp.initialsHidden
        initialsLabel.text = pp.initials
        profileImageView.layer.cornerRadius = CGFloat(pp.radius)
        profileImageView.layer.borderColor = pp.borderColor
        profileImageView.layer.borderWidth = CGFloat(pp.borderWidth)
        profileImageView.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func enableOrDisableTableCells() {
        for cell in cells {
            cell.repTextfield.isUserInteractionEnabled = !cell.isUserInteractionEnabled
            cell.isUserInteractionEnabled = !cell.isUserInteractionEnabled
        }
    }
    
    @IBAction func saveSets(_ sender: UIButton) {
        if !isSavedRowVisible {
            let path = IndexPath(row: sets + 1, section: 0)
            sets += 1
            isSaved = true
            setTableView.insertRows(at: [path], with: .right)
            enableOrDisableTableCells()
        }
    }
    @IBAction func undoButton(_ sender: UIButton) {
        let path = IndexPath(row: sets, section: 0)
        sets -= 1
        setTableView.deleteRows(at: [path], with: .fade)
        enableOrDisableTableCells()
        isSavedRowVisible = false
        isSaved = false
    }
    
    //MARK: - UIScrollViewDelegate
    
    //MARK: - Add custom nib view
    //        let view2 = Push_Ups.instanceFromNib()
    //        self.optionsView.addSubview(view2)
    //        optionsView.contentSize = CGSize(width: optionsView.frame.width, height: view2.frame.height)

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
