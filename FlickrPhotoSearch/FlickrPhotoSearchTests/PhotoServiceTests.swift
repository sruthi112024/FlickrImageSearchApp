//
//  PhotoServiceTests.swift
//  FlickrPhotoSearchTests
//
//  Created by Sruthi on 7/3/24.
//

import XCTest
@testable import FlickrPhotoSearch

class PhotoServiceTests: XCTestCase {
    func testFetchPhotos() {
        let mockService = MockNetworkServiceImpl()
        let photoService = PhotoService(networkService: mockService)
        let viewModel = PhotoViewModel(photoService: photoService)
        
        let item = Item(title: "Test", link: "https://example.com", media: Media(m: "https://example.com/image.jpg"), dateTaken: "2024-07-03T00:00:00Z", description: "Test description", published: "2024-07-03T00:00:00Z", author: "Test author", authorID: "12345", tags: "test")
        let response = Photos(title: "Test Title", link: "https://example.com", description: "Test Description", modified: "2024-07-03T00:00:00Z", generator: "Test Generator", items: [item])
        mockService.result = .success(response)
        
        let expectation = self.expectation(description: "Fetch Photos")
        
        viewModel.searchText = "test"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertFalse(viewModel.items.isEmpty, "Photos should not be empty")
            XCTAssertEqual(viewModel.items.first?.title, "Test")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
