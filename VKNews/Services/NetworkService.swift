//
//  NetworkService.swift
//  VKNews
//
//  Created by Matvei Bykadorov on 17.03.2023.
//

import Foundation

final class NetworkService {
    
    private let authService: AuthService
    
    init(authService: AuthService = SceneDelegate.shared().authService) {
        self.authService = authService
    }
    
    func getFeed() {
        
        guard let token = authService.token else {return}
        
        var components = URLComponents()
        var allParams = ["filters": "post,photo"]
        allParams["access_token"] = token
        allParams["v"] = Api.version
        
        components.scheme = Api.scheme
        components.host = Api.host
        components.path = Api.newsFeed
        components.queryItems = allParams.map{URLQueryItem(name: $0.key, value: $0.value)}
        
        let url = components.url!
        print(url)
    }
}

struct Api {
    static let scheme = "https"
    static let host = "api.vk.com"
    static let version = "5.131"
    static let newsFeed = "/method/newsfeed.get"
}
