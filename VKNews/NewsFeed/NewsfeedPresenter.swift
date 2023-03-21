//
//  NewsfeedPresenter.swift
//  VKNews
//
//  Created by Matvei Bykadorov on 21.03.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsfeedPresentationLogic {
    func presentData(response: Newsfeed.Model.Response.ResponseType)
}

class NewsfeedPresenter: NewsfeedPresentationLogic {
    weak var viewController: NewsfeedDisplayLogic?
    
    func presentData(response: Newsfeed.Model.Response.ResponseType) {
        
        switch response {
            case .presentNewsFeed(feed: let feed):
                let cellArr = feed.items.map { feedItem in
                    cellViewModel(from: feedItem)
                }
                let feedViewModel = FeedViewModel(cellArr: cellArr)
                viewController?.displayData(viewModel: .displayNewsFeed(feedViewModel: feedViewModel))
        }
    }
    
    private func cellViewModel(from feedItem: FeedItem) -> FeedViewModel.Cell {
        return FeedViewModel.Cell(iconUrlString: "",
                                  name: "future name",
                                  date: String(feedItem.date),
                                  post: feedItem.text,
                                  likes: String(feedItem.views?.count ?? 0),
                                  comments: String(feedItem.views?.count ?? 0),
                                  shares: String(feedItem.reposts?.count ?? 0),
                                  views: String(feedItem.views?.count ?? 0))
    }
}
