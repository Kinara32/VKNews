//
//  NewsFeedCellLayoutCalculator.swift
//  VKNews
//
//  Created by Matvei Bykadorov on 25.03.2023.
//

import Foundation

struct Sizes: FeedCellSizes {
    var postLabelFrame: CGRect
    var attachmentFrame: CGRect
}

protocol FeedCellLayoutCalculatorProtocol {
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes
}

final class FeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {
    
    private let screenWidth: CGFloat
    init(screenWidth: CGFloat) {
        self.screenWidth = screenWidth
    }
    
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes {
        Sizes(postLabelFrame: .zero, attachmentFrame: CGRect(x: 0, y: 0, width: 150, height: 150))
    }
}
