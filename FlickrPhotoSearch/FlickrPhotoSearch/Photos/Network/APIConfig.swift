//
//  APIConfig.swift
//  FlickrPhotoSearch
//
//  Created by Sruthi on 7/3/24.
//

import Foundation

struct APIConfig {
    static let baseURL = "https://api.flickr.com/services/feeds/"
    
    static func photosPublicFeedURL(tags: String) -> URL? {
        return URL(string: "\(baseURL)photos_public.gne?format=json&nojsoncallback=1&tags=\(tags)")
    }
}
