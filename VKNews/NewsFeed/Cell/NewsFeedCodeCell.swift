//
//  NewsFeedCodeCell.swift
//  VKNews
//
//  Created by Matvei Bykadorov on 28.03.2023.
//

import Foundation
import UIKit

protocol CodeCellDelegate: AnyObject {
    func revealPost(for cell: NewsFeedCodeCell)
}

final class NewsFeedCodeCell: UITableViewCell {
    
    static let reuseId = "NewsFeedCodeCell"
    weak var delegate: CodeCellDelegate?
    
    // First layer
    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Second layer
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let postLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Constants.postLabelFont
        label.textColor = #colorLiteral(red: 0.2273307443, green: 0.2323131561, blue: 0.2370453477, alpha: 1)
        return label
    }()
    let moreTextButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.setTitleColor(#colorLiteral(red: 0.4691888094, green: 0.6887934804, blue: 0.8642576933, alpha: 1), for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .center
        button.setTitle("Показать полностью...", for: .normal)
        return button
    }()
    let postImageView: WebImageView = {
        let imageView = WebImageView()
        return imageView
    }()
    let bottomView: UIView = {
        let view = UIView()
        return view
    }()
    
    // Third layer on topView
    let iconImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 36 / 2
        imageView.clipsToBounds = true
        return imageView
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.2273307443, green: 0.2323131561, blue: 0.2370453477, alpha: 1)
        return label
    }()
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768454671, green: 0.6187268496, blue: 0.6644299626, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    // Third layer on bottomView
    let likesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let commentsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let repostsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let viewsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Fourth layer on bottomView
    let likesImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "heart"))
        image.tintColor = #colorLiteral(red: 0.5768454671, green: 0.6187268496, blue: 0.6644299626, alpha: 1)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    let commentsImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "message"))
        image.tintColor = #colorLiteral(red: 0.5768454671, green: 0.6187268496, blue: 0.6644299626, alpha: 1)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    let repostsImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "arrowshape.turn.up.right"))
        image.tintColor = #colorLiteral(red: 0.5768454671, green: 0.6187268496, blue: 0.6644299626, alpha: 1)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    let viewsImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "eye.fill"))
        image.tintColor = #colorLiteral(red: 0.5768454671, green: 0.6187268496, blue: 0.6644299626, alpha: 1)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    let likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768454671, green: 0.6187268496, blue: 0.6644299626, alpha: 1)
        label.lineBreakMode = .byClipping
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    let commentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768454671, green: 0.6187268496, blue: 0.6644299626, alpha: 1)
        label.lineBreakMode = .byClipping
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    let repostsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768454671, green: 0.6187268496, blue: 0.6644299626, alpha: 1)
        label.lineBreakMode = .byClipping
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    let viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5768454671, green: 0.6187268496, blue: 0.6644299626, alpha: 1)
        label.lineBreakMode = .byClipping
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        contentView.backgroundColor = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)
        moreTextButton.addTarget(self, action: #selector(moreTextButtonTouch(sender:)), for: .touchUpInside)
        
        overlayFirstLayer()
        overlaySecondLayer()
        overlayThirdLayerTop()
        overlayThirdLayerBottom()
        overlayFourthLayerBottom()

    }
    
    func setUI(viewModel: FeedCellViewModel) {

        iconImageView.setIcon(viewModel.iconUrlString)
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postLabel.text = viewModel.post
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        repostsLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views
        
        postLabel.frame = viewModel.sizes.postLabelFrame
        postImageView.frame = viewModel.sizes.attachmentFrame
        bottomView.frame = viewModel.sizes.bottomViewFrame
        moreTextButton.frame = viewModel.sizes.moreTextButtonFrame
        
        if let photoAttachment = viewModel.photoAttachment {
            postImageView.setIcon(photoAttachment.photoURL)
            postImageView.isHidden = false
        } else {
            postImageView.isHidden = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func moreTextButtonTouch(sender: UIButton) {
        delegate?.revealPost(for: self)
    }
    
    // First layer
    private func overlayFirstLayer() {
        contentView.addSubview(cardView)
        cardView.fillSuperview(padding: UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16))
    }
    
    // Second layer
    private func overlaySecondLayer() {
        cardView.addSubview(topView)
        cardView.addSubview(postLabel)
        cardView.addSubview(moreTextButton)
        cardView.addSubview(postImageView)
        cardView.addSubview(bottomView)
        
        // topView constraints
        topView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8).isActive = true
        topView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8).isActive = true
        topView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
    }
    
    // Third top layer
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
    
    // Third bottom layer
    private func overlayThirdLayerBottom() {
        bottomView.addSubview(likesView)
        bottomView.addSubview(commentsView)
        bottomView.addSubview(repostsView)
        bottomView.addSubview(viewsView)
        
        // likesView constraints
        likesView.heightAnchor.constraint(equalTo: bottomView.heightAnchor).isActive = true
        likesView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor).isActive = true
        likesView.widthAnchor.constraint(equalToConstant: 78).isActive = true
        
        // commentsView constraints
        commentsView.heightAnchor.constraint(equalTo: bottomView.heightAnchor).isActive = true
        commentsView.leadingAnchor.constraint(equalTo: likesView.trailingAnchor).isActive = true
        commentsView.widthAnchor.constraint(equalToConstant: 78).isActive = true
        
        // repostsView constraints
        repostsView.heightAnchor.constraint(equalTo: bottomView.heightAnchor).isActive = true
        repostsView.leadingAnchor.constraint(equalTo: commentsView.trailingAnchor).isActive = true
        repostsView.widthAnchor.constraint(equalToConstant: 78).isActive = true
        
        // viewsView constraints
        viewsView.heightAnchor.constraint(equalTo: bottomView.heightAnchor).isActive = true
        viewsView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor).isActive = true
        viewsView.widthAnchor.constraint(equalToConstant: 78).isActive = true
    }
    
    // Fourth bottom layer
    func overlayFourthLayerBottom() {
        likesView.addSubview(likesImage)
        likesView.addSubview(likesLabel)
        helpInFourthLayer(view: likesView, imageView: likesImage, label: likesLabel)
        
        commentsView.addSubview(commentsImage)
        commentsView.addSubview(commentsLabel)
        helpInFourthLayer(view: commentsView, imageView: commentsImage, label: commentsLabel)
        
        repostsView.addSubview(repostsImage)
        repostsView.addSubview(repostsLabel)
        helpInFourthLayer(view: repostsView, imageView: repostsImage, label: repostsLabel)
        
        viewsView.addSubview(viewsImage)
        viewsView.addSubview(viewsLabel)
        viewsImage.centerYAnchor.constraint(equalTo: viewsView.centerYAnchor).isActive = true
        viewsImage.leadingAnchor.constraint(equalTo: viewsView.leadingAnchor, constant: 8).isActive = true
        viewsImage.widthAnchor.constraint(equalToConstant: 22).isActive = true
        viewsImage.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        viewsLabel.centerYAnchor.constraint(equalTo: viewsView.centerYAnchor).isActive = true
        viewsLabel.leadingAnchor.constraint(equalTo: viewsImage.trailingAnchor, constant: 4).isActive = true
        viewsLabel.trailingAnchor.constraint(equalTo: viewsView.trailingAnchor).isActive = true
        
    }
    
    func helpInFourthLayer(view: UIView, imageView: UIImageView, label: UILabel) {

        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 4).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}
