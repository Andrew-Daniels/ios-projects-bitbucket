//
//  ArticleTableViewCell.swift
//  LayoutTest
//
//  Created by Andrew Daniels on 1/18/20.
//  Copyright © 2020 Andrew Daniels. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var articleCollectionView: ArticleCollectionView!
    
    var articleSection: ArticleSectionModel! {
        didSet {
            articleCollectionView.articleSection = articleSection
            articleCollectionView.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
