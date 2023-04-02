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
    
    var cellLayoutCalculator: FeedCellLayoutCalculatorProtocol? = {
        guard let width = SceneDelegate.shared().window?.windowScene?.screen.bounds.width,
                let height = SceneDelegate.shared().window?.windowScene?.screen.bounds.height else {return nil}
        return FeedCellLayoutCalculator(screenWidth: min(width, height))
    }()
    
    var dateFormatter: DateFormatter {
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "ru_RU")
        dt.dateFormat = "d MMM 'в' HH:mm"
        return dt
    }
    
    func presentData(response: Newsfeed.Model.Response.ResponseType) {
        
        switch response {
            case .presentNewsFeed(feed: let feed, revealdedPostIds: let revealdedPostIds):
                print(revealdedPostIds)
                let cellArr = feed.items.map { feedItem in
                    cellViewModel(from: feedItem, profiles: feed.profiles, groups: feed.groups, revealdedPostIds: revealdedPostIds)
                }
                let feedViewModel = FeedViewModel(cellArr: cellArr)
                viewController?.displayData(viewModel: .displayNewsFeed(feedViewModel: feedViewModel))
        }
    }
    
    private func cellViewModel(from feedItem: FeedItem, profiles: [Profile], groups: [Group], revealdedPostIds: [Int]) -> FeedViewModel.Cell {
        
        let profile = profile(for: feedItem.sourceId, profiles: profiles, groups: groups)
        
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormatter.string(from: date)
        let photoAttachment = photoAttachment(feedItem: feedItem)
        let isFullSized = revealdedPostIds.contains { $0 == feedItem.postId }
        
        let sizes = cellLayoutCalculator?.sizes(postText: feedItem.text, photoAttachment: photoAttachment, isFullSizedPost: isFullSized) ?? Sizes(postLabelFrame: .zero, moreTextButtonFrame: .zero, attachmentFrame: .zero, bottomViewFrame: .zero, totalHeight: 300)
        
        
        
        return FeedViewModel.Cell(postId: feedItem.postId,
                                  iconUrlString: profile?.photo ?? "",
                                  name: profile?.name ?? "",
                                  date: dateTitle,
                                  post: feedItem.text,
                                  likes: String(feedItem.likes?.count ?? 0),
                                  comments: String(feedItem.comments?.count ?? 0),
                                  shares: String(feedItem.reposts?.count ?? 0),
                                  views: String(feedItem.views?.count ?? 0),
                                  photoAttachment: photoAttachment,
                                  sizes: sizes)
        
    }
    
    private func profile(for sourseId: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresenatable? {
        let profilesOrGroups: [ProfileRepresenatable] = sourseId >= 0 ? profiles : groups
        return profilesOrGroups.first(where: { $0.id == abs(sourseId) })
    }
    
    private func photoAttachment(feedItem: FeedItem) -> FeedViewModel.FeedCellPhotoAttachment? {
        guard let photos = feedItem.attachments?.compactMap({ $0.photo }), let firstPhoto = photos.first else {return nil}
        
        return FeedViewModel.FeedCellPhotoAttachment(photoURL: firstPhoto.srcBIG, width: firstPhoto.width, height: firstPhoto.height)
    }
}
