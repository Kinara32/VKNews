//
//  NewsfeedInteractor.swift
//  VKNews
//
//  Created by Matvei Bykadorov on 21.03.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsfeedBusinessLogic {
    func makeRequest(request: Newsfeed.Model.Request.RequestType)
}

class NewsfeedInteractor: NewsfeedBusinessLogic {
    
    var presenter: NewsfeedPresentationLogic?
    var service: NewsfeedService?
    private let networkDataFetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    private var revealedPostId = [Int]()
    private var feedResponse: FeedResponse?
    
    func makeRequest(request: Newsfeed.Model.Request.RequestType) {
        if service == nil {
            service = NewsfeedService()
        }
        switch request {
            case .getNewsFeed:
                print(".getFeed Interactor")
                
                networkDataFetcher.getFeed { [weak self] (feedResponse) in
                    self?.feedResponse = feedResponse
                    self?.presentFeed()
                }
            case .revealPostId(postId: let postId):
                revealedPostId.append(postId)
                presentFeed()
        }
    }
    
    private func presentFeed() {
        guard let feedResponse = feedResponse else { return }
        presenter?.presentData(response: .presentNewsFeed(feed: feedResponse, revealdedPostIds: revealedPostId))
    }
    
}
