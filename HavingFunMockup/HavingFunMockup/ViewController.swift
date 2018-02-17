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

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var initialsLabel: UILabel!
    @IBOutlet weak var statsView: UIView!
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
        if !filter {
            cell.profilePicture(pp: ProfilePicture(tag: indexPath.row, image: profileImages[indexPath.row].profileImage, initials: profileImages[indexPath.row].getInitials(), name: profileImages[indexPath.row].name))
        } else {
            cell.profilePicture(pp: ProfilePicture(tag: indexPath.row, image: filteredAthletes[indexPath.row].profileImage, initials: filteredAthletes[indexPath.row].getInitials(), name: filteredAthletes[indexPath.row].name))
        }
        return cell
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
        let sVC = segue.destination as! SecondViewController
        let sender = sender as! CollectionViewCell
        sVC.profilePicture = sender.getProfilePicture()
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
        
        profileImages.append(Athlete(name: "Vin Diesel", profileImage: #imageLiteral(resourceName: "Vin Diesel")))
        profileImages.append(Athlete(name: "Kurt Russell", profileImage: #imageLiteral(resourceName: "Kurt Russell")))
        profileImages.append(Athlete(name: "Will Smith", profileImage: #imageLiteral(resourceName: "Will Smith")))
        profileImages.append(Athlete(name: "Chris Pratt", profileImage: #imageLiteral(resourceName: "Chris Pratt")))
        profileImages.append(Athlete(name: "Chris Hemsworth", profileImage: #imageLiteral(resourceName: "Chris Hemsworth")))
        profileImages.append(Athlete(name: "Robert Downey Jr.", profileImage: #imageLiteral(resourceName: "Robert Downey Jr")))
        profileImages.append(Athlete(name: "Mark Ruffalo", profileImage: #imageLiteral(resourceName: "Mark Ruffalo")))
        profileImages.append(Athlete(name: "Bradley Cooper", profileImage: #imageLiteral(resourceName: "Bradley Cooper")))
        filteredAthletes = profileImages
        athletesSubView.layer.cornerRadius = 10
        athletesSubView.layer.borderWidth = 2
        athletesSubView.layer.borderColor = UIColor.black.cgColor
        statsView.layer.cornerRadius = 10
        setProfilePicture(pp: ProfilePicture(tag: 1, image: profileImages[1].profileImage, initials: "ACD", name: "Andrew Charles Daniels"))
        //tableView.register(UINib(nibName: "CustomHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "CustomHeader")
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let orientation = UIDevice.current.orientation
        setCollectionViewLayout(toInterfaceOrientation: orientation)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Keyboard Functions
    
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
    
    //MARK: - Profile Picture Functions
    
    func setProfilePicture(pp: ProfilePicture) {
        profileImageView.image = pp.image
        initialsLabel.isHidden = pp.initialsHidden
        initialsLabel.text = pp.initials
        profileImageView.layer.cornerRadius = CGFloat(pp.radius)
        profileImageView.layer.borderColor = pp.borderColor
        profileImageView.layer.borderWidth = CGFloat(pp.borderWidth)
        profileImageView.layer.masksToBounds = true
        profileImageView.backgroundColor = UIColor.white
    }
    
    //MARK: - UICollectionView Layout
    
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        setCollectionViewLayout(toInterfaceOrientation: toInterfaceOrientation)
    }
    
    func setCollectionViewLayout(toInterfaceOrientation: UIInterfaceOrientation) {
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        if ((toInterfaceOrientation == UIInterfaceOrientation.landscapeLeft) || (toInterfaceOrientation == UIInterfaceOrientation.landscapeRight)){
            
            layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        }
        else{
            layout.scrollDirection = UICollectionViewScrollDirection.vertical
        }
    }
    
    func setCollectionViewLayout(toInterfaceOrientation: UIDeviceOrientation) {
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        if ((toInterfaceOrientation == UIDeviceOrientation.landscapeLeft) || (toInterfaceOrientation == UIDeviceOrientation.landscapeRight)){
            
            layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        }
        else{
            layout.scrollDirection = UICollectionViewScrollDirection.vertical
        }
    }

    

}

