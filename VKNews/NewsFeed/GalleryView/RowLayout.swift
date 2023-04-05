//
//  RowLayout.swift
//  VKNews
//
//  Created by Matvei Bykadorov on 03.04.2023.
//

import Foundation
import UIKit

protocol RowLayoutDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, photoAtIndexPath indexPath: IndexPath) -> CGSize
}

class RowLayout: UICollectionViewLayout {
    weak var delegate: RowLayoutDelegate!
    
    static var numbersOfRows = 2
    fileprivate var cellPadding: CGFloat = 8
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    fileprivate var contentWidth: CGFloat = 0
    fileprivate var contentHeight: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        let insets = collectionView.contentInset
        return collectionView.bounds.height - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        contentWidth = 0
        cache = []
        guard cache.isEmpty == true, let collectionView = collectionView else { return }
        var photos = [CGSize]()
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let photoSize = delegate.collectionView(collectionView, photoAtIndexPath: indexPath)
            photos.append(photoSize)
        }
        guard var rowHeight = RowLayout.rowHeightCounter(superviewWidth: collectionView.frame.width, photoArray: photos) else { return }
        rowHeight /= CGFloat(RowLayout.numbersOfRows)
        
        let photosRations = photos.map{$0.height / $0.width}
        var yOffset = [CGFloat]()
        for row in 0..<RowLayout.numbersOfRows {
            yOffset.append(CGFloat(row) * rowHeight)
        }
        var xOffset = [CGFloat](repeating: 0, count: RowLayout.numbersOfRows)
        var row = 0
        for item in 0..<collectionView.numberOfItems(inSection: 0){
            let indexPath = IndexPath(item: item, section: 0)
            
            let ratio = photosRations[indexPath.row]
            let width = rowHeight / ratio
            let frame = CGRect(x: xOffset[row], y: yOffset[row], width: width, height: rowHeight)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            let attribure = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attribure.frame = insetFrame
            cache.append(attribure)
            contentWidth = max(contentWidth, frame.maxX)
            xOffset[row] += width
            row = row < (RowLayout.numbersOfRows - 1) ? (row + 1) : 0
        }
    }
    
    static func rowHeightCounter(superviewWidth: CGFloat, photoArray: [CGSize]) -> CGFloat? {
        var rowHeight: CGFloat
        let photoWithMinRatio = photoArray.min { (first, second) in
            (first.height / first.width) < (second.height / second.width)
        }
        guard let myPhotoWithMinRatio = photoWithMinRatio else { return nil }
        let difference = superviewWidth / myPhotoWithMinRatio.width
        rowHeight = myPhotoWithMinRatio.height * difference
        rowHeight *= CGFloat(numbersOfRows)
        return rowHeight
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        for attribute in cache {
            if attribute.frame.intersects(rect) {
                visibleLayoutAttributes.append(attribute)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        cache[indexPath.row]
    }
}
