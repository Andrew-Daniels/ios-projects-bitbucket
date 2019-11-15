//
//  BaseViewController.swift
//  PickupGames
//
//  Created by Andrew Daniels on 9/23/19.
//  Copyright © 2019 Andrew Daniels. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var isConnectedToInternet: Bool = true
    
    weak var loadingViewController: LoadingViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func checkForInternetConnection() -> Bool {
        
        if !isConnectedToInternet {
            let alert = UIAlertController(title: "Connection Offline", message: "You aren't connected to the internet, check your connection and try again.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alert.addAction(ok)
            
            self.present(alert, animated: true, completion: nil)
        }
        return isConnectedToInternet
    }
    
    func startLoading(withText: String? = nil, completionHandler: @escaping (_ isResponse : Bool) -> Void) {
        DispatchQueue.main.async {
            if self.loadingViewController == nil {
                let main = UIStoryboard(name: "Main", bundle: nil)
                
                guard let loadingViewController = main.instantiateViewController(withIdentifier: LoadingViewController.storyboardIdentifier) as? LoadingViewController
                    else {
                        return
                }
                self.loadingViewController = loadingViewController
                self.loadingViewController?.setLoadingText(text: withText)
                self.present(self.loadingViewController!, animated: true, completion: {
                    completionHandler(true)
                })
            }
        }
    }
    
    func finishLoading(completionHandler: @escaping (_ isResponse : Bool) -> Void) {
        self.loadingViewController?.dismiss(animated: true) {
            self.loadingViewController = nil
            completionHandler(true)
        }
    }

}
