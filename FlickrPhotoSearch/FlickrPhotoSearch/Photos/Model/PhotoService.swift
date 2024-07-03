//
//  PhotoService.swift
//  FlickrPhotoSearch
//
//  Created by Sruthi on 7/3/24.
//

import Foundation
import Combine


class PhotoService {
    private let networkService: NetworkService
    
    init(networkService: NetworkService = NetworkServiceImlp()) {
        self.networkService = networkService
    }
    
    func fetchPhotos(for tags: String) -> AnyPublisher<[Item], Error> {
        guard let url = APIConfig.photosPublicFeedURL(tags: tags) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return networkService.fetch(url: url)
            .map { (response: Photos) in response.items }
            .eraseToAnyPublisher()
    }
}


