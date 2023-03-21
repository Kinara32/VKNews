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
    
    func makeRequest(request: Newsfeed.Model.Request.RequestType) {
        if service == nil {
            service = NewsfeedService()
        }
        switch request {
            case .getNewsFeed:
                print(".getFeed Interactor")
                networkDataFetcher.getFeed {[weak self] feedResponse in
                    guard let feedResponse = feedResponse else {return}
                    self?.presenter?.presentData(response: .presentNewsFeed(feed: feedResponse))
                }
        }
    }
    
}
