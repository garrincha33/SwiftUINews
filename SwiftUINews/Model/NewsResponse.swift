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
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable, Identifiable {
    let id = UUID()
    let author: String?
    let url: String
    let source, title: String
    let articleDescription: String?
    let image: String?
    let date: Date

    enum CodingKeys: String, CodingKey {
        case author, url, source, title
        case articleDescription = "description"
        case image, date
    }
}

