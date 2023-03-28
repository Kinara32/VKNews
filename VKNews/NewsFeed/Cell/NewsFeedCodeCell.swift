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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .cyan
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
