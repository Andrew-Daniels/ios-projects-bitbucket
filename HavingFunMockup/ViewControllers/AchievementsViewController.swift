//
//  AchievementsViewController.swift
//  HavingFunMockup
//
//  Created by Andrew Daniels on 3/25/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import UIKit

class AchievementsViewController: UIViewController {

    
    @IBOutlet weak var blackView: UIView!
    
    
    var newCoord = CGPoint(x: 0, y: 0)
    var firstCoord = CGPoint(x: 0, y: 0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //blackView.translatesAutoresizingMaskIntoConstraints = false
        let panGestureToCell = UILongPressGestureRecognizer(target: self, action: #selector(AchievementsViewController.handlePan(recognizer:)))
        panGestureToCell.minimumPressDuration = 0.0
        blackView.addGestureRecognizer(panGestureToCell)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func handlePan(recognizer: UILongPressGestureRecognizer) {
        if recognizer.view == nil {
            return
        }
        if recognizer.state == .began {
            
        } else if recognizer.state == .ended {
            
        }
        self.newCoord = recognizer.location(in: self.view)
        let x = self.newCoord.x - (recognizer.view?.frame.width ?? 0 / 2)
        let y = self.newCoord.y - (recognizer.view?.frame.height ?? 0 / 2)
        blackView.frame = CGRect(x: x + 50, y: y + 50, width: blackView.frame.width, height: blackView.frame.height)
        
        print("New coordinate : x = \(x), y = \(y)")
        self.view.bringSubview(toFront: blackView)
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
