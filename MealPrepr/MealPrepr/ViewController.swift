//
//  ViewController.swift
//  MealPrepr
//
//  Created by Andrew Daniels on 11/19/19.
//  Copyright © 2019 Andrew Daniels. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        AccountSingleton.instance.createAccount(email: "email@email.com", password: "thisismypassword", firstName: "Andrew", lastName: "Daniels") { (result) in
//            switch result {
//            case .success(let account):
//                print(account);
//                break
//            case .failure(let error):
//                print(error)
//                break
//            }
//        }
        
        AccountSingleton.instance.login(withEmail: "email@email.com", password: "thisismypassword") { (result) in
            switch result {
            case .success(let account):
                print(account);
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    


}

