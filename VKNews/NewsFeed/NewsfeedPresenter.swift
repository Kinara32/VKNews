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
                let cellArr = feed.items.map { feedItem in
                    cellViewModel(from: feedItem, profiles: feed.profiles, groups: feed.groups, revealdedPostIds: revealdedPostIds)
                }
                let feedViewModel = FeedViewModel(cellArr: cellArr)
                
                viewController?.displayData(viewModel: .displayNewsFeed(feedViewModel: feedViewModel))
                
            case .presentUserInfo(user: let user):
                let userViewModel = UserViewModel(photoUrlString: user?.photo100)
                viewController?.displayData(viewModel: .displayUser(userViewModel: userViewModel))
        }
        
    }
    
    private func cellViewModel(from feedItem: FeedItem, profiles: [Profile], groups: [Group], revealdedPostIds: [Int]) -> FeedViewModel.Cell {
        
        let profile = profile(for: feedItem.sourceId, profiles: profiles, groups: groups)
        
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormatter.string(from: date)
        let photoAttachments = photoAttachments(feedItem: feedItem)
        let isFullSized = revealdedPostIds.contains { $0 == feedItem.postId }
        
        let sizes = cellLayoutCalculator?.sizes(postText: feedItem.text, photoAttachments: photoAttachments, isFullSizedPost: isFullSized) ?? Sizes(postLabelFrame: .zero, moreTextButtonFrame: .zero, attachmentFrame: .zero, bottomViewFrame: .zero, totalHeight: 300)
        
        let postText = feedItem.text?.replacingOccurrences(of: "<br>", with: "\n")
        
        return FeedViewModel.Cell(postId: feedItem.postId,
                                  iconUrlString: profile?.photo ?? "",
                                  name: profile?.name ?? "",
                                  date: dateTitle,
                                  post: postText,
                                  likes: formattedCounter(feedItem.likes?.count),
                                  comments: formattedCounter(feedItem.comments?.count),
                                  shares: formattedCounter(feedItem.reposts?.count),
                                  views: formattedCounter(feedItem.views?.count),
                                  photoAttachments: photoAttachments,
                                  sizes: sizes)
        
    }
    
    private func formattedCounter(_ counter: Int?) -> String? {
        guard let counter = counter, counter > 0 else { return nil }
        var counterString = String(counter)
        if  4...6 ~= counterString.count {
            counterString = String(counterString.dropLast(3)) + "K"
        } else if counterString.count > 6 {
            counterString = String(counterString.dropLast(6)) + "M"
        }
        return counterString
    }
    
    private func profile(for sourseId: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresenatable? {
        let profilesOrGroups: [ProfileRepresenatable] = sourseId >= 0 ? profiles : groups
        return profilesOrGroups.first(where: { $0.id == abs(sourseId) })
    }
    
    private func photoAttachment(feedItem: FeedItem) -> FeedViewModel.FeedCellPhotoAttachment? {
        guard let photos = feedItem.attachments?.compactMap({ $0.photo }), let firstPhoto = photos.first else { return nil }
        
        return FeedViewModel.FeedCellPhotoAttachment(photoURL: firstPhoto.srcBIG, width: firstPhoto.width, height: firstPhoto.height)
    }
    private func photoAttachments(feedItem: FeedItem) -> [FeedViewModel.FeedCellPhotoAttachment] {
        guard let attachments = feedItem.attachments else { return [] }
        return attachments.compactMap { (attachment) -> FeedViewModel.FeedCellPhotoAttachment? in
            guard let photo = attachment.photo else { return nil }
            return FeedViewModel.FeedCellPhotoAttachment(photoURL: photo.srcBIG, width: photo.width, height: photo.height)
        }
    }
}
