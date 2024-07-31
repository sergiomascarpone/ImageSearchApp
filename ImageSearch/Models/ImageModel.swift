//
//  ImageModel.swift
//  ImageSearch
//
//  Created by Sergio Mascarpone on 31.07.24.
//

import Foundation

struct ImageModel: Identifiable, Decodable {
    let id: String
    let description: String?
    let urls: ImageURLs
    
    struct ImageURLs: Decodable {
        let small: URL
        let regular: URL
    }
}
