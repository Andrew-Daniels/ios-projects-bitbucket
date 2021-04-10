//
//  AlignmentFlowLayout.swift
//  LayoutTest
//
//  Created by Andrew Daniels on 1/22/20.
//  Copyright © 2020 Andrew Daniels. All rights reserved.
//

import UIKit

protocol ContentDelegate {
    func reloadContent()
}

class AlignmentFlowLayout: UICollectionViewFlowLayout {
    
    private var cache: [UICollectionViewLayoutAttributes] = []

    private var contentHeight: CGFloat = 0
    private var contentWidth: CGFloat = 0

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
    
    override func prepare() {
        super.prepare()
          // 1
        guard
          cache.isEmpty,
          let collectionView = collectionView,
            let cvDelegate = collectionView.delegate as? UICollectionViewDelegateFlowLayout,
            let sectionInset = cvDelegate.collectionView?(collectionView, layout: self, insetForSectionAt: 0),
            let minInteritemSpacing = cvDelegate.collectionView?(collectionView, layout: self, minimumInteritemSpacingForSectionAt: 0),
            let minLineSpacing = cvDelegate.collectionView?(collectionView, layout: self, minimumLineSpacingForSectionAt: 0)
          else {
            return
        }
        
        self.sectionInset = sectionInset
        self.minimumInteritemSpacing = minInteritemSpacing
        self.minimumLineSpacing = minLineSpacing
        
        self.contentWidth = collectionView.bounds.width - (sectionInset.left + sectionInset.right)
        self.contentHeight = collectionView.bounds.height - (sectionInset.top + sectionInset.bottom)
        
        if self.scrollDirection == .vertical {
            let numSections = collectionView.numberOfSections
            var xOffset: [CGFloat] = .init(repeating: sectionInset.left, count: numSections)
            var yOffset: [CGFloat] = .init(repeating: sectionInset.top, count: numSections)
            
            for item in 0..<collectionView.numberOfItems(inSection: 0) {
                let indexPath = IndexPath(item: item, section: 0)
                let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                if let sizeForItem = cvDelegate.collectionView?(collectionView, layout: self, sizeForItemAt: indexPath) {
                    if xOffset[0] + sizeForItem.width + sectionInset.right > contentWidth {
                        xOffset[0] = sectionInset.left
                        yOffset[0] += sizeForItem.height + minimumLineSpacing
                    }
                    let frame = CGRect(x: xOffset[0], y: yOffset[0], width: sizeForItem.width, height: sizeForItem.height)
                    attribute.frame = frame
                    xOffset[0] = frame.maxX + sectionInset.left
                    cache.append(attribute)
                    self.contentHeight = attribute.frame.maxY + sectionInset.bottom
                }
            }
        }
        
        if self.scrollDirection == .horizontal {
            var numColumns = 0
            var xOffsetByRow: [Int:CGFloat] = [0:sectionInset.left]
            var yOffset: [CGFloat] = [sectionInset.top]
            
            for item in 0..<collectionView.numberOfItems(inSection: 0) {
                let indexPath = IndexPath(item: item, section: 0)
                let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                if let sizeForItem = cvDelegate.collectionView?(collectionView, layout: self, sizeForItemAt: indexPath) {
                    
                    let numItemsPerColumn = Int(floor(self.contentHeight / (sizeForItem.height + minimumLineSpacing)))
                    let minimumLineSpacing = self.contentHeight.truncatingRemainder(dividingBy: (sizeForItem.height + self.minimumLineSpacing)) / CGFloat(numItemsPerColumn - 1)
                    
                    let frame = CGRect(x: xOffsetByRow[item - (numItemsPerColumn * numColumns)] ?? sectionInset.left, y: yOffset[numColumns], width: sizeForItem.width, height: sizeForItem.height)
                    attribute.frame = frame
                    
                    xOffsetByRow.updateValue((xOffsetByRow[item - (numItemsPerColumn * numColumns)] ?? self.sectionInset.left) + attribute.frame.width + self.minimumInteritemSpacing, forKey: item - (numItemsPerColumn * numColumns))
                    yOffset[numColumns] = attribute.frame.maxY + minimumLineSpacing
                    
                    if let offset = xOffsetByRow[item - (numItemsPerColumn * numColumns)], offset > self.contentWidth {
                        self.contentWidth = offset
                    }
                    
                    if (item + 1) % numItemsPerColumn == 0 {
                        numColumns += 1
                        yOffset.append(sectionInset.top)
                    }
                }
                cache.append(attribute)
            }
        }
        
        
//        let columnWidth = contentWidth / CGFloat(numberOfColumns)
//        var xOffset: [CGFloat] = []
//        for column in 0..<numberOfColumns {
//          xOffset.append(CGFloat(column) * columnWidth)
//        }
//        var column = 0
//        var yOffset: [CGFloat] = .init(repeating: 0, count: numberOfColumns)
//
//        // 3
//        for item in 0..<collectionView.numberOfItems(inSection: 0) {
//          let indexPath = IndexPath(item: item, section: 0)
//
//          // 4
//          let photoHeight = delegate?.collectionView(
//            collectionView,
//            heightForPhotoAtIndexPath: indexPath) ?? 180
//          let height = cellPadding * 2 + photoHeight
//          let frame = CGRect(x: xOffset[column],
//                             y: yOffset[column],
//                             width: columnWidth,
//                             height: height)
//          let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
//
//          // 5
//          let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
//          attributes.frame = insetFrame
//          cache.append(attributes)
//
//          // 6
//          contentHeight = max(contentHeight, frame.maxY)
//          yOffset[column] = yOffset[column] + height
//
//          column = column < (numberOfColumns - 1) ? (column + 1) : 0
//        }
    }
    
    override var collectionViewContentSize: CGSize {
      return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForElements(
                    in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        // Loop through the cache and look for items in the rect
        for attributes in cache {
          if attributes.frame.intersects(rect) {
            visibleLayoutAttributes.append(attributes)
          }
        }
        return visibleLayoutAttributes

//        guard let atts = super.layoutAttributesForElements(in:rect)?.map({$0.copy() as! UICollectionViewLayoutAttributes}), let cV = self.collectionView else {return []}
//        var x: CGFloat = sectionInset.left
//        let collectionViewHeight = cV.frame.height
//        // Filter attributes to compute only cell attributes
//        let cellAttributes = atts.filter({ $0.representedElementCategory == .cell; })
//
//        if self.scrollDirection == .vertical {
//            var y: CGFloat = -1.0
//
//            for currentCell in cellAttributes {
//                if currentCell.frame.origin.y >= y { x = sectionInset.left }
//                currentCell.frame.origin.x = x
//                x += currentCell.frame.width + minimumInteritemSpacing
//                y = currentCell.frame.maxY
//            }
//        }
//        else {
//            var offset = 0
//            var column = [Int:CellFrameOrigin]()
//            if self.contentViewSize == nil {
//                self.contentViewSize = CGSize(width: self.collectionView?.frame.width ?? 0.0, height: self.collectionView?.frame.height ?? 0.0)
//            } else {
//                self.contentViewSize.height = self.collectionView?.frame.height ?? 0.0
//            }
//            for (i, currentCell) in cellAttributes.enumerated() {
//                if offset > 0 {
//                    let cellFrameOrigin = (column[i - offset] ?? CellFrameOrigin())
//                    currentCell.frame.origin.x = cellFrameOrigin.nextx + minimumInteritemSpacing
//                    currentCell.frame.origin.y = cellFrameOrigin.nexty
//                }
//                else {
//                    x = sectionInset.left
//                    currentCell.frame.origin.x = x
//                }
//                let nextx = (column[i - offset] ?? CellFrameOrigin()).nextx + currentCell.frame.width + (minimumInteritemSpacing * 2)
//                if nextx > self.contentViewSize.width {
//                    self.contentViewSize.width = nextx
//                }
//                column.updateValue(CellFrameOrigin(nextx: nextx, nexty: currentCell.frame.minY) , forKey: i - offset)
//
//                if (currentCell.frame.origin.y + currentCell.frame.height + sectionInset.bottom) == collectionViewHeight {
//                    offset = i + 1
//                }
//            }
//        }
//        return atts
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
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

extension AlignmentFlowLayout: ContentDelegate {
    
    func reloadContent() {
        self.cache = []
    }
    
}
