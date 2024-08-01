//
//  ContentView.swift
//  ImageSearch
//
//  Created by Sergio Mascarpone on 31.07.24.
//

// Основной вью и его настройка/отображение
import SwiftUI
import URLImage

struct ContentView: View {
    @StateObject private var viewModel = ImageSearchViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Поиск...", text: $viewModel.searchText, onCommit: {
                        viewModel.searchImages()
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    
                    Button(action: {
                        viewModel.searchImages()
                    }) {
                        Text("Поиск")
                    }
                    .padding()
                }
                
                if viewModel.images.isEmpty {
                    Text("Изображение не найдено")
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
            .navigationBarTitle("Поиск Изображений")
        }
    }
}
