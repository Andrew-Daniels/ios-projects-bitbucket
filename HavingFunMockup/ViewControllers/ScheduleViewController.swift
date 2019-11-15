//
//  ScheduleViewController.swift
//  HavingFunMockup
//
//  Created by Andrew Daniels on 3/14/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var collectionViewBackColor: UIColor!
    var selectedCollectionCell: ScheduleCollectionViewCell!
    
    var week = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    var today = ["Mon" : 2]
    var dateIndex = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ScheduleTableViewCell
        cell.availableSpotsView.layer.cornerRadius = 5
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ScheduleCollectionViewCell
        let dayViewHeight = cell.dayView.frame.height
        cell.dayView.layer.cornerRadius = dayViewHeight / 2
        collectionViewBackColor = cell.dayView.backgroundColor
        cell.dayView.backgroundColor = UIColor.white
        
        //Configure the cell
        
//        var cellDateIndex = 0
//        for currentDayString in today.keys {
//            cellDateIndex = week.index(of: currentDayString)!
//        }
//        cell.dayOfWeekLabel.text = week[cellDateIndex + indexPath.row]
//        guard case cell.dayLabel.text! = String(describing: today.values.first) else {
//            return cell
//        }
//        guard case cell.dayOfWeekLabel.text! = String(describing: ) else {
//            return cell
//        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedCell = selectedCollectionCell {
            selectedCell.dayView.backgroundColor = UIColor.white
        }
        let cell = collectionView.cellForItem(at: indexPath) as! ScheduleCollectionViewCell
        cell.dayView.backgroundColor = collectionViewBackColor
        selectedCollectionCell = cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
