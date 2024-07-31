//
//  ImageSearchModel.swift
//  ImageSearch
//
//  Created by Sergio Mascarpone on 31.07.24.
//

import Foundation
import Combine

class ImageSearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var images = [ImageModel]()
    private var cancellable: AnyCancellable?
    
    func searchImages() {
        let accessKey = "xZON2_J1xxcgWyiVsCZe8uwGdAi66YqhJ8crT4cH6Lk" // реальный ключ
        guard let url = URL(string: "https://api.unsplash.com/search/photos?query=\(searchText)&client_id=\(accessKey)") else {
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: SearchResult.self, decoder: JSONDecoder())
            .map { $0.results }
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink { [weak self] images in
                self?.images = images
            }
    }
    
    struct SearchResult: Decodable {
        let results: [ImageModel]
    }
}
