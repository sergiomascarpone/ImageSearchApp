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
//                Text("Поиск Изображения")
//                    .font(.largeTitle)
//                    .padding(.top)
                
                HStack {
                    TextField("Введите текст...", text: $viewModel.searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    Button(action: {
                        viewModel.searchImages()
                    }) {
                        Text("Поиск")
                        Image(systemName: "magnifyingglass")
                            .font(.title2)
                    }
                    .padding(.trailing)
                }
                
                Spacer()
                
                if $viewModel.images.isEmpty {
                    VStack(spacing: 10) {
                        Text("Изображение не найдено")
                            .font(.title)
                            .foregroundColor(.blue)
                        
                        Text("Введите корректный текст для поиска")
                            .font(.subheadline)
                            .padding(.horizontal, 30)
                    }
                    .padding(.top, 30)
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
                            ForEach(viewModel.images) { image in
                                URLImage(image.urls.small) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(10)
                                        .clipped()
                                }
                            }
                        }
                        .padding()
                    }
                }
                Spacer()
            }
            .background(Color(.systemGray6).edgesIgnoringSafeArea(.all)) // Добавляем фон
            .navigationTitle("Поиск картинок")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
