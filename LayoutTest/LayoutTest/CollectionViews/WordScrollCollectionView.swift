//
//  WordScrollCollectionView.swift
//  LayoutTest
//
//  Created by Andrew Daniels on 1/21/20.
//  Copyright © 2020 Andrew Daniels. All rights reserved.
//

import UIKit

class WordScrollCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private let cellIdentifier = "wordListVerticalScrollCell"
    public var articleSection: ArticleSectionModel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.delegate = self
        self.dataSource = self
        self.collectionViewLayout = AlignmentFlowLayout()
        self.contentInsetAdjustmentBehavior = .always
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articleSection?.articles.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! WordScrollCollectionViewCell
        let article = articleSection.articles[indexPath.row]
        cell.article = article
        cell.nameLabel.text = article.articleName
        cell.subscriberCountLabel.text = String(article.articleSubscriberCount)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let article = articleSection.articles[indexPath.row]
        let cellSize = WordScrollCollectionViewCell.getSizeForCell(withObject: article)
        return CGSize(width: cellSize.width, height: cellSize.height)
    }
}
