//
//  NewsFeedCellLayoutCalculator.swift
//  VKNews
//
//  Created by Matvei Bykadorov on 25.03.2023.
//

import Foundation
import UIKit

struct Sizes: FeedCellSizes {
    var postLabelFrame: CGRect
    var moreTextButtonFrame: CGRect
    var attachmentFrame: CGRect
    var bottomViewFrame: CGRect
    var totalHeight: CGFloat
}

enum Constants {
    static let cardInsets = UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16)
    static let topViewHeight: CGFloat = 36
    static let postLabelInsets = UIEdgeInsets(top: 8 + topViewHeight + 8, left: 8, bottom: 8, right: 8)
    static let postLabelFont = UIFont.systemFont(ofSize: 15)
    static let bottomViewHeight: CGFloat = 44
    static let minifiedPostLimitLines: CGFloat = 8
    static let minifiedPostLines: CGFloat = 6
    static let moreTextButtonSize = CGSize(width: 170, height: 30)
    static let moreTextButtonInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
}

protocol FeedCellLayoutCalculatorProtocol {
    func sizes(postText: String?, photoAttachments: [FeedCellPhotoAttachmentViewModel], isFullSizedPost: Bool) -> FeedCellSizes
}

final class FeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {
    private let screenWidth: CGFloat
    init(screenWidth: CGFloat) {
        self.screenWidth = screenWidth
    }

    func sizes(postText: String?, photoAttachments: [FeedCellPhotoAttachmentViewModel], isFullSizedPost: Bool) -> FeedCellSizes {
        var showMoreTextButton = false

        // MARK: Работа с postLabelFrame

        let cardViewWidth = screenWidth - Constants.cardInsets.left - Constants.cardInsets.right

        var postLabelFrame = CGRect(x: Constants.postLabelInsets.left, y: Constants.postLabelInsets.top, width: .zero, height: .zero)

        if let text = postText, !text.isEmpty {
            let width = cardViewWidth - Constants.postLabelInsets.left - Constants.postLabelInsets.right
            var height = text.height(width: width, font: Constants.postLabelFont)

            let limitHeight = Constants.postLabelFont.lineHeight * Constants.minifiedPostLimitLines
            if !isFullSizedPost, height > limitHeight {
                height = Constants.postLabelFont.lineHeight * Constants.minifiedPostLines
                showMoreTextButton = true
            }
            postLabelFrame.size = CGSize(width: width, height: height)
        }

        // MARK: Работа с moreTextButtonFrame

        var moreTextButtonSize = CGSize.zero
        if showMoreTextButton {
            moreTextButtonSize = Constants.moreTextButtonSize
        }
        let moreTextButtonOrigin = CGPoint(x: Constants.moreTextButtonInsets.left, y: postLabelFrame.maxY)
        let moreTextButtonFrame = CGRect(origin: moreTextButtonOrigin, size: moreTextButtonSize)

        // MARK: Работа с attachmentFrame

        let attachmentTop = postLabelFrame.size == CGSize.zero ? Constants.postLabelInsets.top : moreTextButtonFrame.maxY + Constants.postLabelInsets.bottom
        var attachmentFrame = CGRect(x: 0, y: attachmentTop, width: .zero, height: .zero)

        if let attachment = photoAttachments.first {
            let ratio = CGFloat(attachment.height) / Double(attachment.width)
            if photoAttachments.count == 1 {
                attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio)
            } else if photoAttachments.count > 1 {
                var photos = [CGSize]()
                for photo in photoAttachments {
                    let photoSize = CGSize(width: CGFloat(photo.width), height: CGFloat(photo.height))
                    photos.append(photoSize)
                }
                if let rowHeight = RowLayout.rowHeightCounter(superviewWidth: cardViewWidth, photoArray: photos) {
                    attachmentFrame.size = CGSize(width: cardViewWidth, height: rowHeight)
                }
            }
        }

        // MARK: Работа с bottomViewFrame

        let bottomViewTop = max(postLabelFrame.maxY, attachmentFrame.maxY)
        let bottomViewFrame = CGRect(x: 0, y: bottomViewTop, width: cardViewWidth, height: Constants.bottomViewHeight)

        // MARK: Работа с totalHeight

        let totalHeight = bottomViewFrame.maxY + Constants.cardInsets.bottom

        return Sizes(postLabelFrame: postLabelFrame, moreTextButtonFrame: moreTextButtonFrame, attachmentFrame: attachmentFrame, bottomViewFrame: bottomViewFrame, totalHeight: totalHeight)
    }
}

extension String {
    func height(width: CGFloat, font: UIFont) -> CGFloat {
        let textSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        let size = boundingRect(with: textSize,
                                options: .usesLineFragmentOrigin,
                                attributes: [NSAttributedString.Key.font: font],
                                context: nil)
        return ceil(size.height)
    }
}
