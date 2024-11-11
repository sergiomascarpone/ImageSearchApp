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
                Text("Поиск Изображения").font(.largeTitle)
                HStack {
                    TextField("Введите текст...", text: $viewModel.searchText, onCommit: {
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
                Spacer()
                
                if $viewModel.images.isEmpty {
                    Text("Изображение не найдено").font(.title).foregroundColor(.blue).offset(y: -30)
                    Text("Введите корректный текст для поиска").font(.subheadline).padding(.horizontal, 30).offset(y: -30)
                        .multilineTextAlignment(.center).lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true).frame(maxWidth: .infinity)
                    
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
