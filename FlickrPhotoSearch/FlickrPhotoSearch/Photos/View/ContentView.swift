//
//  ContentView.swift
//  FlickrPhotoSearch
//
//  Created by Sruthi on 7/3/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PhotoViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchText)
                    .padding()
                Spacer()
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .padding()
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                            ForEach(viewModel.items) { item in
                                NavigationLink(destination: DetailView(item: item)) {
                                    AsyncImage(url: URL(string: item.media.m)) { image in
                                        image.resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 100, height: 100)
                                            .clipped()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Flickr Search")
        }
    }
}

