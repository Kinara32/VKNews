//
//  FeedResponse.swift
//  VKNews
//
//  Created by Matvei Bykadorov on 20.03.2023.
//

import Foundation

struct FeedResponseWrapped: Decodable {
    let response: FeedResponse
}

struct FeedResponse: Decodable {
    var items: [FeedItem]
}

struct FeedItem: Decodable {
    let sourceId: Int
    let postId: Int
    let text: String?
    let date: Double
    let comments: CountableItem?
    let likes: CountableItem?
    let reports: CountableItem?
    let views: CountableItem?
}

struct CountableItem: Decodable {
    let count: Int
}
