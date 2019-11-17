//
//  BaseUIImageView.swift
//  PickupGames
//
//  Created by Andrew Daniels on 11/16/19.
//  Copyright © 2019 Andrew Daniels. All rights reserved.
//

import UIKit

class BaseUIImageView: UIImageView {
    
    private var url: URL!
    
    func load(url: URL) {
        if url != self.url {
            self.url = url
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }
        }
    }
}
