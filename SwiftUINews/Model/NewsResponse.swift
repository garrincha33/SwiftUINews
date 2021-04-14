//
//  NewsResponse.swift
//  SwiftUINews
//
//  Created by Richard Price on 14/04/2021.
//

import Foundation

// MARK: - NewsResponse
//create a struct using https://app.quicktype.io/ from the apihttps://lil.software/api/

///update the articleDescription = "description" in coding keys, description is a key word so the coding
///key resolves this issue, also we need to make NewsResponse Identifiable
///this will be used in a list and needs to be unique using an ID
struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}
//step 1 - fix bug removed Date as wrong type and causing failure on API call, nasty bug

    // MARK: - Article
    struct Article: Codable, Identifiable {
        let id = UUID()
        let author: String?
        let title: String?
        let articleDescription: String?
        let url: String?
        let urlToImage: String?
        //let publishedAt: Date? //BUG
        let content: String?

        enum CodingKeys: String, CodingKey {
            case author, title
            case articleDescription = "description"
            case url, urlToImage, content
        }
    }

    // MARK: - Source
    struct Source: Codable {
        let id: String?
        let name: String
    }

extension Article {
    static var dummyData: Article {
        .init(author: "Richard Price", title: "You Can Talk To Me", articleDescription: "featuring how to write songs", url: "https://www.nytimes.com/live/2021/04/13/us/grand-isle-louisiana-vessel-capsize", urlToImage: "https://static01.nyt.com/images/2021/04/13/us/13xp-capsize2/13xp-capsize2-articleLarge.jpg", content: nil)
        
//        .init(author: "Erin Erin", url: "https://www.cbsnews.com/live-updates/derek-chauvin-trial-george-floyd-death-2021-04-13/", source: "CBS News",
//            title: "Derek Chauvin Trial Live Updates: Prosecution rests, defense launches case",
//            articleDescription: "A defense attorney for the fired cop charged in the death of George Floyd began calling witnesses on Tuesday.",
//            image: "https://cbsnews2.cbsistatic.com/hub/i/r/2021/04/13/ef8f2728-fb5b-48d0-9846-f3abc84f8e20/thumbnail/1200x630/da06996db355676d6bb9d6d099bb984b/ap21103520662501.jpg",
//            date: Date())
    }
}
