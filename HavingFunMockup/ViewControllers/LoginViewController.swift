//
//  LoginViewController.swift
//  HavingFunMockup
//
//  Created by Andrew Daniels on 2/6/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class LoginViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        return cell
    }
    

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var showHideButton: UIButton!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var ourFriendsView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var ourFriendCollectionView: UICollectionView!
    var ref: DatabaseReference!
    var handler: DatabaseHandle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        handler = ref.child("userId").observe(.childAdded, with: { (snapshot) in
            if let item = snapshot.value as? String {
                print(item)
            }
        })
        UIApplication.shared.statusBarStyle = .lightContent
        ourFriendsView.layer.cornerRadius = 5
        passwordView.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showHidePassword(_ sender: UIButton) {
        passwordField.isSecureTextEntry = !passwordField.isSecureTextEntry
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
    }
    
    @IBAction func login(_ sender: Any) {
        ref.child("userId").childByAutoId().setValue(usernameTextField.text)
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
