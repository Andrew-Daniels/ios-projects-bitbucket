//
//  WordScrollCollectionViewCell.swift
//  LayoutTest
//
//  Created by Andrew Daniels on 1/21/20.
//  Copyright © 2020 Andrew Daniels. All rights reserved.
//

import UIKit

class WordScrollCollectionViewCell: UICollectionViewCell, CellSizedByObject {
    
    typealias Element = ArticleModel
    
    public var article: ArticleModel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subscriberCountLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        let cornerRadius = self.nameLabel.frame.height / 3
        self.nameLabel.layer.cornerRadius = cornerRadius
        self.subscriberCountLabel.layer.cornerRadius = cornerRadius
        self.subscriberCountLabel.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
    }
    
    static func getSizeForCell(withObject: ArticleModel) -> CGSize {
        let nameLbl = UILabel()
        nameLbl.text = withObject.articleName
        let subscriberCountLbl = UILabel()
        subscriberCountLbl.text = String(withObject.articleSubscriberCount)

        nameLbl.sizeToFit()
        subscriberCountLbl.sizeToFit()

        let width = 40 + nameLbl.frame.width + subscriberCountLbl.frame.width
        let height = 20 + nameLbl.frame.height
        return CGSize(width: width, height: height)
    }
}
