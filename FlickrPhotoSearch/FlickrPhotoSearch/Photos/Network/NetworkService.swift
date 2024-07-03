//
//  NetworkService.swift
//  FlickrPhotoSearch
//
//  Created by Sruthi on 7/3/24.
//

import Foundation
import Combine

class NetworkServiceImlp: NetworkService {
    func fetch<T: Decodable>(url: URL) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

protocol NetworkService {
    func fetch<T: Decodable>(url: URL) -> AnyPublisher<T, Error>
}


