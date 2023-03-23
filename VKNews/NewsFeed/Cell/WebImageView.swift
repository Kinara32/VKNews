//
//  WebImageView.swift
//  VKNews
//
//  Created by Matvei Bykadorov on 22.03.2023.
//

import UIKit

class WebImageView: UIImageView {
    
    func setIcon(_ imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        if let cachedResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            image = UIImage(data: cachedResponse.data)
            print("cache")
            return
        }
        print("internet")
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, _) in
            DispatchQueue.main.async {
                if let data = data, let response = response {
                    self?.image = UIImage(data: data)
                    self?.handleLoadedImage(data: data, response: response)
                }
            }
        }
        dataTask.resume()
    }
    
    private func handleLoadedImage(data: Data, response: URLResponse) {
        guard let responseURL = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))
    }
}
