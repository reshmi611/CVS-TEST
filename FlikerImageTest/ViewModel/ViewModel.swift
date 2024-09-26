//
// ViewModel.swift
// FlikerImageTest
//
//  Created by Reshmi Divi on 26/09/24.
//

import Foundation
import SwiftUI
//
struct ResponseImages: Codable {
    let title: String
    let link: String
    let description: String
   // let modified: Date
    let generator: String
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let title: String
    let link: String
    let media: Media
    let dateTaken: String
    let description: String
    let published: String
    let author, authorID, tags: String

    enum CodingKeys: String, CodingKey {
        case title, link
        case dateTaken = "date_taken"
        case description, published, author,media
        case authorID = "author_id"
        case tags
    }
}
// MARK: - Media
struct Media: Codable {
    let m: String
}

@MainActor class ImageListViewModel: ObservableObject {
    var url =  "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags="
    @Published var images = [Item]()
    @Published var searchText: String = ""
    func fetchData()  async {
        guard let downloadedPosts: ResponseImages = await WebService().downloadData(fromURL: url + searchText) else {return }
        images = downloadedPosts.items
    }
}
