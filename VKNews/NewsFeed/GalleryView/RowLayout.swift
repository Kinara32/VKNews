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
    
    fileprivate var numbersOfRows = 1
    fileprivate var cellPadding: CGFloat = 8
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    fileprivate var contentWidth: CGFloat = 0
    fileprivate var contentHeight: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        let insets = collectionView.contentInset
        return collectionView.bounds.height - (insets.left + insets.right)
    }
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    override func prepare() {
        guard cache.isEmpty == true, let collectionView = collectionView else { return }
        var photos = [CGSize]()
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            let photoSize = delegate.collectionView(collectionView, photoAtIndexPath: indexPath)
            photos.append(photoSize)
        }
        guard let rowHeight = rowHeightCounter(superviewWidth: collectionView.frame.width, photoArray: photos) else { return }
    }
    
    private func rowHeightCounter(superviewWidth: CGFloat, photoArray: [CGSize]) -> CGFloat? {
        var rowHeight: CGFloat
        let photoWithMinRatio = photoArray.min { (first, second) in
            (first.height / first.width) < (second.height / second.width)
        }
        guard let myPhotoWithMinRatio = photoWithMinRatio else { return nil }
        let difference = superviewWidth / myPhotoWithMinRatio.width
        rowHeight = myPhotoWithMinRatio.height * difference
        return rowHeight
    }
}
