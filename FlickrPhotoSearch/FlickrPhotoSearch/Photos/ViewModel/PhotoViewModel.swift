//
//  PhotoViewModel.swift
//  FlickrPhotoSearch
//
//  Created by Sruthi on 7/3/24.
//

import SwiftUI
import Combine

class PhotoViewModel: ObservableObject {
    @Published var items = [Item]()
    @Published var isLoading = false
    @Published var searchText = "" {
        didSet {
            fetchPhotos(for: searchText)
        }
    }
    
    private let photoService: PhotoService
    private var cancellables = Set<AnyCancellable>()
    
    init(photoService: PhotoService = PhotoService()) {
        self.photoService = photoService
    }
    
    func fetchPhotos(for tags: String) {
        guard !tags.isEmpty else {
            self.items = []
            return
        }
        
        isLoading = true
        
        photoService.fetchPhotos(for: tags)
            .sink { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .failure(let error):
                    print("Error fetching photos: \(error)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] photos in
                self?.items = photos
            }
            .store(in: &cancellables)
    }
}
