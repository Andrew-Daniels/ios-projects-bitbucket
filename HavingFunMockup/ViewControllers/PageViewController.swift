//
//  PageViewController.swift
//  HavingFunMockup
//
//  Created by Andrew Daniels on 2/17/18.
//  Copyright © 2018 Andrew Daniels. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    var counter = 0
    var timer = Timer()
    var nextViewControllerIndex: Int?
    var main = DispatchQueue.main
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: false,
                               completion: nil)
        }
        let pageControl = UIPageControl.appearance()
        pageControl.currentPageIndicatorTintColor = UIColor(displayP3Red: 205/255, green: 253/255, blue: 52/255, alpha: 1)
        pageControl.pageIndicatorTintColor = UIColor(displayP3Red: 33/255, green: 49/255, blue: 84/255, alpha: 1)
        // Do any additional setup after loading the view.
    }
    
    @objc func timerAction() {
        counter += 1
        if counter % 10 == 0 {
            main.async {
                self.animation()
            }
        }
    }
    
    func animation() {
        //let randomNum = arc4random_uniform(UInt32(orderedViewControllers.count))
        if let nextIndex = nextViewControllerIndex {
            if nextIndex >= orderedViewControllers.count {
                setViewControllers([orderedViewControllers[0]], direction: .reverse, animated: true, completion: nil)
                nextViewControllerIndex = 1
                return
            }
            setViewControllers([orderedViewControllers[nextIndex]], direction: .forward, animated: true, completion: nil)
            nextViewControllerIndex = nextIndex + 1
        } else {
            setViewControllers([orderedViewControllers[1]], direction: .forward, animated: true, completion: nil)
            nextViewControllerIndex = 2
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newViewController(stat: "Fastest Mile"),
                self.newViewController(stat: "Weighted Squats"),
                self.newViewController(stat: "Weighted Dead Lifts")]
    }()
    
    
    private func newViewController(stat: String) -> UIViewController {
        let vC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DailyStats") as! DailyStatsViews
        if stat == "Fastest Mile" {
            vC.actualStat = "06:13:33"
            vC.initials = "ACD"
            vC.profileImage = #imageLiteral(resourceName: "IMG_2508")
            vC.statType = "Fastest Mile"
        }
        if stat == "Weighted Squats" {
            vC.actualStat = "300 lbs"
            vC.initials = "WS"
            vC.profileImage = #imageLiteral(resourceName: "Will Smith")
            vC.statType = "Weighted Squats"
        }
        if stat == "Weighted Dead Lifts" {
            vC.actualStat = "50 lbs"
            vC.initials = "MC"
            vC.profileImage = #imageLiteral(resourceName: "Miley Cyrus")
            vC.statType = "Weighted Dead Lifts"
        }
        return vC
    }
    
    //MARK: - UIPageViewDataSource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
            return orderedViewControllers.first
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
            return orderedViewControllers.last
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    //MARK: - UIPageViewDelegate
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        counter = 0
    }
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        counter = 0
        for controller in orderedViewControllers {
            if previousViewControllers.contains(controller) {
                if let index = orderedViewControllers.index(of: controller) {
                    nextViewControllerIndex = Int(index) + 2
                    return
                }
            }
        }
    }
    
    //MARK: - Method for page dot indicators
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = orderedViewControllers.index(of: firstViewController) else {
                return 0
        }

        return firstViewControllerIndex
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
