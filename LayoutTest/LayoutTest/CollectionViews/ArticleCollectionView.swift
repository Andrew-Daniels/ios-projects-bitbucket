//
//  ArticleCollectionView.swift
//  LayoutTest
//
//  Created by Andrew Daniels on 1/18/20.
//  Copyright © 2020 Andrew Daniels. All rights reserved.
//

import Foundation
import UIKit

class ArticleCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let cellIdentifier = "ArticleCell"
    public var articleSection: ArticleSectionModel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.delegate = self
        self.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articleSection?.articles.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ArticleCollectionViewCell
        cell.article = articleSection.articles[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 110)
    }
    
}
