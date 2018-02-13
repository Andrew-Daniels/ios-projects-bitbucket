//
//  ViewController.swift
//  HavingFunMockup
//
//  Created by Andrew Daniels on 2/2/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import UIKit

let cellIdentifier = "Cell"

var profileImages: [Athlete] = []

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var portraitConstraint3: NSLayoutConstraint!
    @IBOutlet weak var portraitConstraint2: NSLayoutConstraint!
    @IBOutlet weak var athletesSubView: UIView!
    @IBOutlet weak var portraitConstraint1: NSLayoutConstraint!
    var dailyStats = [["Fastest Mile": "Andrew Daniels"], ["Records Beaten": "2"], ["Achievements Earned": "0"], ["Most Consecutive":"Kevin Kipkemboi"]]
    var filteredAthletes: [Athlete] = []
    var filter = true
    var device = UIDevice()
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyStats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! TableViewCell
        cell.backgroundColor = UIColor.black
        let childStats = dailyStats[indexPath.row]
        for (a, b) in childStats {
            cell.mainLabel.text = a
            cell.labelData.text = b
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomHeader") as! CustomHeader
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    //MARK: - UISearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
        let filteredAth = profileImages.filter({(item: Athlete) -> Bool in
                
                let stringMatch = item.name.lowercased().range(of: searchText.lowercased())
                return stringMatch != nil ? true : false
            })
            filteredAthletes = filteredAth
            collectionView.reloadData()
        } else {
            filteredAthletes = profileImages
            collectionView.reloadData()
        }
    }
    
    
    
    //MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !filter {
            return profileImages.count
        } else {
            return filteredAthletes.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CollectionViewCell
        cell.layer.cornerRadius = 35
        cell.layer.borderColor = UIColor.green.cgColor
        cell.layer.borderWidth = 4
        cell.tag = indexPath.row
        if !filter {
            if let profileImage = profileImages[indexPath.row].profileImage {
                cell.profileImageView.image = profileImage
                cell.initialsLabel.isHidden = true
            } else {
                cell.profileImageView.image = nil
                cell.initialsLabel.text = profileImages[indexPath.row].getInitials()
                cell.initialsLabel.isHidden = false
            }
            return cell
        } else {
            if let profileImage = filteredAthletes[indexPath.row].profileImage {
                cell.profileImageView.image = profileImage
                cell.initialsLabel.isHidden = true
            } else {
                cell.profileImageView.image = nil
                cell.initialsLabel.text = filteredAthletes[indexPath.row].getInitials()
                cell.initialsLabel.isHidden = false
            }
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "workoutSelector", sender: self.collectionView.cellForItem(at: indexPath))
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func setBackground() {
        if view.backgroundColor != .black {
            view.backgroundColor = .black
            let blurView = view.viewWithTag(1)
            blurView?.removeFromSuperview()
        } else if !UIAccessibilityIsReduceTransparencyEnabled() {
            view.backgroundColor = .clear
            
            let blurEffect = UIBlurEffect(style: .light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            blurEffectView.tag = 1
            view.addSubview(blurEffectView) //if you have more UIViews, use an insertSubview API to place it where needed
        } else {
            view.backgroundColor = .black
        }
    }
    
//    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
//        if toInterfaceOrientation == .landscapeLeft || toInterfaceOrientation == .landscapeRight {
//            self.tabBarController?.tabBar.isHidden = true
//        } else if toInterfaceOrientation == .portrait {
//            print("will rotate portrait")
//            self.tabBarController?.tabBar.isHidden = false
//        }
//
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.searchBar.endEditing(true)
    }
    
    //MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let logView = segue.destination as! SecondViewController
        let sender = sender as! CollectionViewCell
        let tag = sender.tag
        if !filter {
            logView.name = profileImages[tag].name
            logView.profileImage = profileImages[tag].profileImage
            logView.initials = profileImages[tag].getInitials()
        } else {
            logView.name = filteredAthletes[tag].name
            logView.profileImage = filteredAthletes[tag].profileImage
            logView.initials = filteredAthletes[tag].getInitials()
        }
    }
    
    //MARK: - Developer Created Functions
    
    
    
    //MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        profileImages.append(Athlete(name: "Selena Gomez", profileImage: #imageLiteral(resourceName: "Selena Gomez")))
        profileImages.append(Athlete(name: "Miley Cyrus", profileImage: #imageLiteral(resourceName: "Miley Cyrus")))
        profileImages.append(Athlete(name: "Andrew Daniels", profileImage: #imageLiteral(resourceName: "Andrew Daniels")))
        profileImages.append(Athlete(name: "Jassi Singh", profileImage: nil))
        profileImages.append(Athlete(name: "Harrison Ford", profileImage: #imageLiteral(resourceName: "Harrison Ford")))
        profileImages.append(Athlete(name: "Samuel L. Jackson", profileImage: #imageLiteral(resourceName: "Samuel L Jackson")))
        profileImages.append(Athlete(name: "Jennifer Lawrence", profileImage: #imageLiteral(resourceName: "Jennifer Lawrence")))
        profileImages.append(Athlete(name: "Ben Affleck", profileImage: #imageLiteral(resourceName: "Ben Affleck")))
        profileImages.append(Athlete(name: "Leonardo DiCaprio", profileImage: #imageLiteral(resourceName: "Leonardo Dicaprio")))
        profileImages.append(Athlete(name: "Scarlett Johansson", profileImage: #imageLiteral(resourceName: "Scarlett Johansson")))
        profileImages.append(Athlete(name: "Margot Robbie", profileImage: #imageLiteral(resourceName: "Margot Robbie")))
        profileImages.append(Athlete(name: "Channing Tatum", profileImage: #imageLiteral(resourceName: "Channing Tatum")))
        profileImages.append(Athlete(name: "Vin Diesel", profileImage: #imageLiteral(resourceName: "Vin Diesel")))
        profileImages.append(Athlete(name: "Kurt Russell", profileImage: #imageLiteral(resourceName: "Kurt Russell")))
        profileImages.append(Athlete(name: "Will Smith", profileImage: #imageLiteral(resourceName: "Will Smith")))
        profileImages.append(Athlete(name: "Chris Pratt", profileImage: #imageLiteral(resourceName: "Chris Pratt")))
        profileImages.append(Athlete(name: "Chris Hemsworth", profileImage: #imageLiteral(resourceName: "Chris Hemsworth")))
        profileImages.append(Athlete(name: "Robert Downey Jr.", profileImage: #imageLiteral(resourceName: "Robert Downey Jr")))
        profileImages.append(Athlete(name: "Mark Ruffalo", profileImage: #imageLiteral(resourceName: "Mark Ruffalo")))
        profileImages.append(Athlete(name: "Bradley Cooper", profileImage: #imageLiteral(resourceName: "Bradley Cooper")))
        filteredAthletes = profileImages
        athletesSubView.layer.cornerRadius = 5
        athletesSubView.layer.borderWidth = 2
        athletesSubView.layer.borderColor = UIColor.black.cgColor
        tableView.register(UINib(nibName: "CustomHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "CustomHeader")
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let orientation = UIDevice.current.orientation
        if orientation == .landscapeLeft || orientation == .landscapeRight {
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= keyboardSize.height
                }
            }
        } else if orientation == .portrait {
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= keyboardSize.height/2
                }
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

    

}

