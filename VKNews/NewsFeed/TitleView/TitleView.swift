//
//  TitleView.swift
//  VKNews
//
//  Created by Matvei Bykadorov on 06.04.2023.
//

import Foundation
import UIKit

protocol TitleViewViewModel {
    var photoUrlString: String? { get }
}

class TitleView: UIView {
    
    private var textField = InsetableTextField()
    
    private var avatarView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .orange
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)
        addSubview(avatarView)
        makeConstraints()
    }
    
    func set(userViewModel: TitleViewViewModel) {
        avatarView.setIcon(userViewModel.photoUrlString)
    }
    
    private func makeConstraints() {
        avatarView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 4).isActive = true
        avatarView.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        avatarView.heightAnchor.constraint(equalTo: textField.heightAnchor, multiplier: 1).isActive = true
        avatarView.widthAnchor.constraint(equalTo: textField.heightAnchor, multiplier: 1).isActive = true
        
        textField.anchor(top: topAnchor,
                         leading: leadingAnchor,
                         bottom: bottomAnchor,
                         trailing: avatarView.leadingAnchor,
                         padding: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 12))
    }
    
    
    override var intrinsicContentSize: CGSize {
        UIView.layoutFittingExpandedSize
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarView.layer.masksToBounds = true
        avatarView.layer.cornerRadius =  avatarView.frame.width / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
