//
//  NewsFeedCodeCell.swift
//  VKNews
//
//  Created by Matvei Bykadorov on 28.03.2023.
//

import Foundation
import UIKit

final class NewsFeedCodeCell: UITableViewCell {
    
    static let reuseId = "NewsFeedCodeCell"
    
    // First layer
    let cardView: UIView = {
        let view = UIView()
//        view.backgroundColor = .systemRed
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Second layer
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return view
    }()
    let postLabel: UILabel = {
        let label = UILabel()
//        label.backgroundColor = .purple
        label.numberOfLines = 0
        label.font = Constants.postLabelFont
        label.textColor = #colorLiteral(red: 0.2273307443, green: 0.2323131561, blue: 0.2370453477, alpha: 1)
        return label
    }()
    let postImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = #colorLiteral(red: 0.9117177725, green: 0.918438971, blue: 0.927837193, alpha: 1)
        return imageView
    }()
    let bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        return view
    }()
    
    // Third layer on topView
    let iconImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.backgroundColor = .magenta
        return imageView
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.2273307443, green: 0.2323131561, blue: 0.2370453477, alpha: 1)
//        label.backgroundColor = .blue
        return label
    }()
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768454671, green: 0.6187268496, blue: 0.6644299626, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12)
//        label.backgroundColor = .orange
        return label
    }()
    
    // Third layer on bottomView
    let likesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        return view
    }()
    let commentsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        return view
    }()
    let repostsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        return view
    }()
    let viewsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        overlayFirstLayer()
        overlaySecondLayer()
        overlayThirdLayerTop()
        overlayThirdLayerBottom()
//        contentView.backgroundColor = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)
//        cardView.backgroundColor = .white
    }
    
    func setUI(viewModel: FeedCellViewModel) {

        iconImageView.setIcon(viewModel.iconUrlString)
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postLabel.text = viewModel.post

        
        postLabel.frame = viewModel.sizes.postLabelFrame
        postImageView.frame = viewModel.sizes.attachmentFrame
        bottomView.frame = viewModel.sizes.bottomViewFrame
        
        if let photoAttachment = viewModel.photoAttachment {
//            postImageView.setIcon(photoAttachment.photoURL)
            postImageView.isHidden = false
        } else {
            postImageView.isHidden = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // First layer
    private func overlayFirstLayer() {
        addSubview(cardView)
        cardView.fillSuperview(padding: UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16))
    }
    // Second layer
    private func overlaySecondLayer() {
        cardView.addSubview(topView)
        cardView.addSubview(postLabel)
        cardView.addSubview(postImageView)
        cardView.addSubview(bottomView)
        
        // topView constraints
        topView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8).isActive = true
        topView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8).isActive = true
        topView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 36).isActive = true
    }
    
    private func overlayThirdLayerTop() {
        topView.addSubview(iconImageView)
        topView.addSubview(nameLabel)
        topView.addSubview(dateLabel)
        
        // iconImageView constraints
        iconImageView.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor).isActive = true
        iconImageView.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 1).isActive = true
        iconImageView.widthAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 1).isActive = true
        
        // nameLabel constraints
        nameLabel.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 1/2).isActive = true
        
        // date constraints
        dateLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8).isActive = true
        dateLabel.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 1/2).isActive = true
    }
    
    private func overlayThirdLayerBottom() {
        bottomView.addSubview(likesView)
        bottomView.addSubview(commentsView)
        bottomView.addSubview(repostsView)
        bottomView.addSubview(viewsView)
        
        
    }
}
