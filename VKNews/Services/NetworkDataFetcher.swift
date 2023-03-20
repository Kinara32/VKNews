//
//  NetworkDataFetcher.swift
//  VKNews
//
//  Created by Matvei Bykadorov on 20.03.2023.
//

import Foundation

protocol DataFetcher {
    func getFeed(response: @escaping (FeedResponse?) -> Void)
}

struct NetworkDataFetcher: DataFetcher {
    
    let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
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
}
