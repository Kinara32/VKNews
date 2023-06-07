//
//  NetworkService.swift
//  VKNews
//
//  Created by Matvei Bykadorov on 17.03.2023.
//

import Foundation

protocol Networking {
    func request(path: String, params: [String: String], completion: @escaping (Data?, Error?) -> Void)
}

final class NetworkService: Networking {
    private let authService: AuthService

    init(authService: AuthService = SceneDelegate.shared().authService) {
        self.authService = authService
    }

    func request(path: String, params: [String: String], completion: @escaping (Data?, Error?) -> Void) {
        guard let token = authService.token else { return }

        var allParams = params
//        allParams["filters"] = "post,photo"
        allParams["access_token"] = token
        allParams["v"] = Api.version
        let url = url(from: path, params: allParams)
        let session = URLSession(configuration: .default)
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
        task.resume()
        print(url)
    }

    private func url(from path: String, params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = Api.scheme
        components.host = Api.host
        components.path = path
        components.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        return components.url!
    }
}

enum Api {
    static let scheme = "https"
    static let host = "api.vk.com"
    static let version = "5.131"
    static let newsFeed = "/method/newsfeed.get"
    static let user = "/method/users.get"
}
