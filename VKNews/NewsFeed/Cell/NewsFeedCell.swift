//
//  NewsFeedCell.swift
//  VKNews
//
//  Created by Matvei Bykadorov on 21.03.2023.
//

import Foundation
import UIKit

protocol FeedCellViewModel {
    var iconUrlString: String { get }
    var photoAttachments: [FeedCellPhotoAttachmentViewModel] { get }
    var name: String { get }
    var date: String { get }
    var post: String? { get }
    var likes: String? { get }
    var comments: String? { get }
    var shares: String? { get }
    var views: String? { get }
    var sizes: FeedCellSizes { get }
}

protocol FeedCellSizes {
    var postLabelFrame: CGRect { get }
    var moreTextButtonFrame: CGRect { get }
    var attachmentFrame: CGRect { get }
    var bottomViewFrame: CGRect { get }
    var totalHeight: CGFloat { get }
}

protocol FeedCellPhotoAttachmentViewModel {
    var photoURL: String? { get }
    var width: Int { get }
    var height: Int { get }
}

class NewsFeedCell: UITableViewCell {
    static let reuseId = "NewsFeedCell"

    @IBOutlet var cardView: UIView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var iconImageView: WebImageView!
    @IBOutlet var postImageView: WebImageView!
    @IBOutlet var bottomView: UIView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var postLabel: UILabel!
    @IBOutlet var likesLabel: UILabel!
    @IBOutlet var commentsLabel: UILabel!
    @IBOutlet var shareLabel: UILabel!
    @IBOutlet var viewsLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView.layer.cornerRadius = iconImageView.frame.width / 2
        iconImageView.clipsToBounds = true

        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        selectionStyle = .none
    }

    func setUI(viewModel: FeedCellViewModel) {
        iconImageView.setIcon(viewModel.iconUrlString)
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postLabel.text = viewModel.post
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        shareLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views

        postLabel.frame = viewModel.sizes.postLabelFrame
        postImageView.frame = viewModel.sizes.attachmentFrame
        bottomView.frame = viewModel.sizes.bottomViewFrame

//        if let photoAttachment = viewModel.photoAttachment {
//            postImageView.setIcon(photoAttachment.photoURL)
//            postImageView.isHidden = false
//        } else {
//            postImageView.isHidden = true
//        }
    }
}
