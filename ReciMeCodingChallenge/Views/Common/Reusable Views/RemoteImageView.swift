//
//  RemoteImageView.swift
//  ReciMeCodingChallenge
//
//  Created by John Paulo on 1/15/23.
//

import SwiftUI

public struct RemoteImage: View {

    @ObservedObject var imageLoader: RemoteImageLoader
    
    let placeholder: UIImage?

    public init(_ url: String?, placeholder: UIImage? = nil) {
        self.imageLoader = RemoteImageLoader(imageURL: url)
        self.placeholder = placeholder
    }

    public var body: some View {
        VStack(alignment: .center, spacing: .zero) {
            VStack(alignment: .center, spacing: .zero) {
                Image(uiImage: UIImage(data: imageLoader.imageData) ?? placeholder ?? UIImage())
                    .resizable()
                    .clipped()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray)
    }
}


final class RemoteImageLoader: ObservableObject {

    @Published var imageData = Data()

    init(imageURL: String?) {
        guard let urlString: String = imageURL, let url: URL = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        let cache = URLCache.shared

        if let data = cache.cachedResponse(for: request)?.data,
           let httpResponse: HTTPURLResponse = cache.cachedResponse(for: request)?.response as? HTTPURLResponse,
           httpResponse.statusCode == 200 {
            self.imageData = data
        } else {
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, _) in
                guard
                    let data: Data = data,
                    let httpResponse: HTTPURLResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 200
                else { return }
                let cachedData = CachedURLResponse(response: httpResponse, data: data)
                cache.storeCachedResponse(cachedData, for: request)
                DispatchQueue.main.async {
                    self.imageData = data
                }
            }).resume()
        }
    }
}
