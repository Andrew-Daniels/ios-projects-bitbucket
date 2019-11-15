//
//  LoadingViewController.swift
//  PickupGames
//
//  Created by Andrew Daniels on 9/30/19.
//  Copyright © 2019 Andrew Daniels. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    
    @IBOutlet weak var errorImageView: UIImageView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var loadingLabel: UILabel!
    
    // MARK: Private Variables
    private var loadingText: String!
    
    // MARK: Public Static Variables
    public static let storyboardIdentifier: String! = "SB_LOADING_VIEWCONTROLLER"
    
    // MARK: Initializers
    init(with loadingText: String? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.setLoadingText(text: loadingText)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingLabel.text = loadingText
        // Do any additional setup after loading the view.
    }

    // MARK: Functions
    func setError(withText: String?) {
        self.setLabelText(text: withText ?? "Error")
        indicatorView.stopAnimating()
        errorImageView.isHidden = false
    }
    
    func setLoadingText(text: String?) {
        self.loadingText = text ?? "Loading"
    }
    
    private func setLabelText(text: String?) {
        setLoadingText(text: text)
        if let _ = self.loadingLabel {
            self.loadingLabel.text = text
        }
    }

}

