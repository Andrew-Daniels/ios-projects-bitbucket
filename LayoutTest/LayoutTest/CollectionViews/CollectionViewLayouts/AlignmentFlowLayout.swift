//
//  AlignmentFlowLayout.swift
//  LayoutTest
//
//  Created by Andrew Daniels on 1/22/20.
//  Copyright © 2020 Andrew Daniels. All rights reserved.
//

import UIKit

class AlignmentFlowLayout: UICollectionViewFlowLayout {
    
    private var contentViewSize: CGSize!

    override init() {
        super.init()
        self.scrollDirection = .horizontal
        
        self.minimumLineSpacing = 5
        self.minimumInteritemSpacing = 5
        self.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override var collectionViewContentSize: CGSize {
        if self.contentViewSize == nil {
            return super.collectionViewContentSize
        }
        return self.contentViewSize
    }
    
    override func layoutAttributesForElements(
                    in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

        guard let atts = super.layoutAttributesForElements(in:rect)?.map({$0.copy() as! UICollectionViewLayoutAttributes}), let cV = self.collectionView else {return []}
        var x: CGFloat = sectionInset.left
        let collectionViewHeight = cV.frame.height
        // Filter attributes to compute only cell attributes
        let cellAttributes = atts.filter({ $0.representedElementCategory == .cell; })
        
        if self.scrollDirection == .vertical {
            var y: CGFloat = -1.0
            
            for currentCell in cellAttributes {
                if currentCell.frame.origin.y >= y { x = sectionInset.left }
                currentCell.frame.origin.x = x
                x += currentCell.frame.width + minimumInteritemSpacing
                y = currentCell.frame.maxY
            }
        }
        else {
            var offset = 0
            var column = [Int:CellFrameOrigin]()
            if self.contentViewSize == nil {
                self.contentViewSize = CGSize(width: self.collectionView?.frame.width ?? 0.0, height: self.collectionView?.frame.height ?? 0.0)
            } else {
                self.contentViewSize.height = self.collectionView?.frame.height ?? 0.0
            }
            for (i, currentCell) in cellAttributes.enumerated() {
                if offset > 0 {
                    let cellFrameOrigin = (column[i - offset] ?? CellFrameOrigin())
                    currentCell.frame.origin.x = cellFrameOrigin.nextx + minimumInteritemSpacing
                    currentCell.frame.origin.y = cellFrameOrigin.nexty
                }
                else {
                    x = sectionInset.left
                    currentCell.frame.origin.x = x
                }
                let nextx = (column[i - offset] ?? CellFrameOrigin()).nextx + currentCell.frame.width + (minimumInteritemSpacing * 2)
                if nextx > self.contentViewSize.width {
                    self.contentViewSize.width = nextx
                }
                column.updateValue(CellFrameOrigin(nextx: nextx, nexty: currentCell.frame.minY) , forKey: i - offset)
                
                if (currentCell.frame.origin.y + currentCell.frame.height + sectionInset.bottom) == collectionViewHeight {
                    offset = i + 1
                }
            }
        }
        return atts
    }
    
    class CellFrameOrigin {
        var nextx: CGFloat!
        var nexty: CGFloat!
        
        init() {
            nextx = 0
            nexty = 0
        }
        
        init(nextx: CGFloat, nexty: CGFloat) {
            self.nextx = nextx
            self.nexty = nexty
        }
    }
}
