//
//  MockNetworkService.swift
//  FlickrPhotoSearchTests
//
//  Created by Sruthi on 7/3/24.
//

import Foundation
import Combine

@testable import FlickrPhotoSearch
class MockNetworkServiceImpl: NetworkService {
    var result: Result<Photos, Error>?
    
    func fetch<T>(url: URL) -> AnyPublisher<T, Error> where T : Decodable {
        if let result = result {
            return result.publisher
                .flatMap { response -> AnyPublisher<T, Error> in
                    if let response = response as? T {
                        return Just(response)
                            .setFailureType(to: Error.self)
                            .eraseToAnyPublisher()
                    } else {
                        return Fail(error: NetworkError.invalidMockData).eraseToAnyPublisher()
                    }
                }
                .eraseToAnyPublisher()
        } else {
            return Fail(error: NetworkError.invalidMockData).eraseToAnyPublisher()
        }
    }
    
    enum NetworkError: Error {
        case invalidMockData
    }
}



