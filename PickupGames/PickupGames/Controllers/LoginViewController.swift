//
//  LoginViewController.swift
//  PickupGames
//
//  Created by Andrew Daniels on 10/26/19.
//  Copyright © 2019 Andrew Daniels. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {
    
    private var entityFactory = EntityFactorySingleton.instance

    override func viewDidLoad() {
        super.viewDidLoad()
//
//            let test = PickupGame()
//                let loc = Location()
//                loc.city = "Hehee"
//                loc.state = "Whowho"
//                loc.streetAddress = "Street"
//                loc.zipCode = 123456
//                test.location = loc
//                test.numberOfAttendees = 5
//                test.numberOfSubscribers = 2
//                test.occursAtDate = Date()
//                test.reoccurring = false
//                test.title = "This is a title don't"
//
//        let _ = self.entityFactory.pickupGames.storage(obj: test).insert(image: UIImage(), withQuality: .highest, forKey: .sports, forIndex: 0) { (result, index) in
//            let _ = self.entityFactory.pickupGames.insertOrUpdate(object: test)
//        }
        
        self.entityFactory.pickupGames.collectionGroup(key: .ingredients).whereField(field: "name", like: "egg").whereField("quantity", isLessThanOrEqualTo: 2).getParentDocuments { (result: Result<[Result<PickupGame, Error>], Error>) in
            switch result {
            case .success(let results):
                for res in results {
                    switch res {
                    case .success(let pug):
                        print(pug)
                        break
                    case .failure(let err):
                        print(err)
                        break
                    }
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
        
//        self.entityFactory.pickupGames.getBy(id: "2oq34JnSlTDftKmT1Jh2") { [weak self] (result) in
//            switch result {
//                case .success(let pugs):
//                    print(pugs)
//                    self?.entityFactory.pickupGames.subscribers(forPickupGame: pugs).getAll(asyncCompleteWithObjects: { (result) in
//                        switch result {
//                            case .success(let subs):
//                                print(subs)
//                                break
//                            case .failure(let error):
//                                print(error)
//                                break
//                        }
//                    })
//                    break
//                case .failure(let error):
//                    print(error)
//                    break
//                }
//        }
    }
    
    @IBAction func login(sender: UIButton) {
        AccountSingleton.instance.login(withEmail: "Andrew", password: "Daniels") { (result) in
            switch result {
            case .success(let account):
                print(account.user)
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    
    @IBAction func logout(sender: UIButton) {
        if AccountSingleton.instance.logout() {
            print("Logged Out")
        } else {
            print("You aren't logged in")
        }
    }
    
    //        AccountSingleton.instance.createAccount(email: "Jassu@email.com", password: "porque4K", firstName: "Jassu", lastName: "Singh") { (account, err) in
    //            guard let user = account?.user else { return }
    //            self.entityFactory.pickupGames.getBy(id: "2oq34JnSlTDftKmT1Jh2") { (pug, err) in
    //                if let pug = pug {
    //                    let sub = PickupGameSubscriber()
    //                    sub.lastName = user.lastName
    //                    sub.firstName = user.firstName
    //                    sub.id = user.id
    //                    let _ = self.entityFactory.pickupGames.subscribers(forPickupGame: pug).insertOrUpdate(object: sub)
    //                }
    //            }
    //        }
//            let test = PickupGame()
//            let loc = Location()
//            loc.city = "Hehee"
//            loc.state = "Whowho"
//            loc.streetAddress = "Street"
//            loc.zipCode = 123456
//            test.location = loc
//            test.numberOfAttendees = 5
//            test.numberOfSubscribers = 2
//            test.occursAtDate = Date()
//            test.reoccurring = false
//            test.title = "This is a title don't"
//
//            let _ = self.entityFactory.pickupGames.insertOrUpdate(object: test)
            
//            self.entityFactory.pickupGames.getBy(id: "fBMZIfj3H2XABQYysB9A") { (pug, err) in
//                print(pug?.occursAtDate.toLocal())
//            }
            
            
    //        self.entityFactory.pickupGames.getBy(id: "6Doc6vstl4R3ncJG634h") { (pug, err) in
    //            if let pug = pug {
    //                self.entityFactory.pickupGames.subscribers(forPickupGame: pug).getAll { (subscribers, err) in
    //                    print(subscribers)
    //                }
    //            }
    //        }

}
