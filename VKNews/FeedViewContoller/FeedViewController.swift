//
//  FeedViewController.swift
//  VKNews
//
//  Created by Matvei Bykadorov on 17.03.2023.
//

import UIKit

class FeedViewController: UIViewController {
    
    private let networkServise = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkServise.getFeed()
        view.backgroundColor = .cyan
    }
}
