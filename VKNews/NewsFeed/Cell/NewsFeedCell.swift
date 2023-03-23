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
    var name: String { get }
    var date: String { get }
    var post: String? { get }
    var likes: String? { get }
    var comments: String? { get }
    var shares: String? { get }
    var views: String? { get }
}

class NewsFeedCell: UITableViewCell {
    
    static let reuseId = "NewsFeedCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconImageView: WebImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var shareLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
    }
}
