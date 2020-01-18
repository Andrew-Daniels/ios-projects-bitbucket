//
//  ArticleCollectionViewCell.swift
//  LayoutTest
//
//  Created by Andrew Daniels on 1/18/20.
//  Copyright © 2020 Andrew Daniels. All rights reserved.
//

import UIKit

class ArticleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    public var article: ArticleModel! {
        didSet {
            image?.image = article?.articleImage
            label?.text = article?.articleName
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
