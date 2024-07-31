//
//  ContentView.swift
//  ImageSearch
//
//  Created by Sergio Mascarpone on 31.07.24.
//

import SwiftUI
import URLImage

struct ContentView: View {
    @StateObject private var viewModel = ImageSearchViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Search...", text: $viewModel.searchText, onCommit: {
                        viewModel.searchImages()
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    
                    Button(action: {
                        viewModel.searchImages()
                    }) {
                        Text("Search")
                    }
                    .padding()
                }
                
                if viewModel.images.isEmpty {
                    Text("No images found")
                        .padding()
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
                            ForEach(viewModel.images) { image in
                                URLImage(image.urls.small) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 100, height: 100)
                                        .clipped()
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationBarTitle("Image Search")
        }
    }
}
