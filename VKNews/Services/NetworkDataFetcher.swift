//
//  NetworkDataFetcher.swift
//  VKNews
//
//  Created by Matvei Bykadorov on 20.03.2023.
//

import Foundation

protocol DataFetcher {
    func getFeed(response: @escaping (FeedResponse?) -> Void)
    func getUser(response: @escaping (UserResponse?) -> Void)
}

struct NetworkDataFetcher: DataFetcher {

    let networking: Networking
    private let authService: AuthService
    
    init(networking: Networking, authService: AuthService = SceneDelegate.shared().authService) {
        self.networking = networking
        self.authService = authService
    }
    
    func getFeed(response: @escaping (FeedResponse?) -> Void) {
        
        networking.request(path: Api.newsFeed, params: ["filters":"post,photo"]) { data, error in
            if let error = error {
                print(error)
                response(nil)
            }
            let decoded = decodeJSON(type: FeedResponseWrapped.self, from: data)
            response(decoded?.response)
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = data, let response = try? decoder.decode(type, from: data) else {return nil}
        return response
    }
    
    func getUser(response: @escaping (UserResponse?) -> Void) {
        guard let userId = authService.userId else { return }
        networking.request(path: Api.user, params: ["user_ids": userId, "fields": "photo_100"]) { data, error in
            if let error = error {
                print(error)
                response(nil)
            }
            let decoded = decodeJSON(type: UserResponseWrapped.self, from: data)
            response(decoded?.response.first)
        }
    }
}
