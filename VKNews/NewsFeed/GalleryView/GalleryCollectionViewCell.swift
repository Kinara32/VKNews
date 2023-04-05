//
//  GalleryCollectionViewCell.swift
//  VKNews
//
//  Created by Matvei Bykadorov on 03.04.2023.
//

import Foundation
import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "GalleryCollectionViewCell"
    
    let imageViewCell: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = #colorLiteral(red: 0.9117177725, green: 0.918438971, blue: 0.927837193, alpha: 1)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageViewCell)

        imageViewCell.fillSuperview()
    }
    
    override func prepareForReuse() {
        imageViewCell.image = nil
    }
    
    func set(imageURL: String?) {
        imageViewCell.setIcon(imageURL)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageViewCell.layer.masksToBounds = true
        imageViewCell.layer.cornerRadius = 10
        contentView.layer.shadowRadius = 3
        contentView.layer.shadowOpacity = 0.4
        contentView.layer.shadowOffset = CGSize(width: 2.5, height: 4)
    }
}
