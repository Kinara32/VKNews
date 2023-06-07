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
    private var userResponse: UserResponse?

    func makeRequest(request: Newsfeed.Model.Request.RequestType) {
        if service == nil {
            service = NewsfeedService()
        }
        switch request {
        case .getNewsFeed:

            networkDataFetcher.getFeed { [weak self] feedResponse in
                self?.feedResponse = feedResponse
                self?.presentFeed()
            }
        case let .revealPostId(postId: postId):
            revealedPostId.append(postId)
            presentFeed()

        case .getUser:
            networkDataFetcher.getUser { [weak self] userResponse in
                self?.userResponse = userResponse
                self?.presenter?.presentData(response: .presentUserInfo(user: userResponse))
            }
        }
    }

    private func presentFeed() {
        guard let feedResponse = feedResponse else { return }
        presenter?.presentData(response: .presentNewsFeed(feed: feedResponse, revealdedPostIds: revealedPostId))
    }
}
