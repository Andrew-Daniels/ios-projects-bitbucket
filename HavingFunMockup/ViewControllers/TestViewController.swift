//
//  TestViewController.swift
//  HavingFunMockup
//
//  Created by Andrew Daniels on 3/31/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import UIKit

class TestViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var testView: UIView!
    @IBOutlet weak var greaterThan100: NSLayoutConstraint!
    
    @IBOutlet weak var exactly100: NSLayoutConstraint!
    
    let main = DispatchQueue.main
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panFunction(recognizer:)))
        panGesture.delegate = self
        testView.addGestureRecognizer(panGesture)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func panFunction(recognizer: UIPanGestureRecognizer) {
        //Do something
        if recognizer.view == nil {
            return
        }
        if recognizer.state == .began {
            //Take note of original location here
        } else if recognizer.state == .changed {
            //Take note of new location here
        } else if recognizer.state == .ended {
            
        }
        //print(recognizer.velocity(in: testView))
        let velocity = recognizer.velocity(in: testView)
        if velocity.y > 1000 {
            self.greaterThan100.isActive = true
            self.exactly100.isActive = false
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            })
        } else if velocity.y < -1000 {
            self.view.layoutIfNeeded()
            self.greaterThan100.isActive = false
            self.exactly100.isActive = true
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            })
        }
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
