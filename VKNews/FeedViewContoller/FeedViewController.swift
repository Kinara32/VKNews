//
//  FeedViewController.swift
//  VKNews
//
//  Created by Matvei Bykadorov on 17.03.2023.
//

import UIKit

class FeedViewController: UIViewController {
    
    private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetcher.getFeed { feedResponse in
            guard let feedResponse = feedResponse else { return }
            print(feedResponse)
        }
        view.backgroundColor = .cyan
    }
}
