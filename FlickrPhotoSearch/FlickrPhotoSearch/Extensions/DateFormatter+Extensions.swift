//
//  DateFormatter+Extensions.swift
//  FlickrPhotoSearch
//
//  Created by Sruthi on 7/3/24.
//

import Foundation

extension DateFormatter {
    static let flickr: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
    
    static let flickrDisplay: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
}
