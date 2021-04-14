//
//  NewsEndpoint.swift
//  SwiftUINews
//
//  Created by Richard Price on 14/04/2021.
//

import Foundation

//create an endpoint using a protocol builder, protocols are good for reusability
protocol APIBuilder {
    var urlRequest: URLRequest { get }
    var baseURL: URL { get }
    var path: String { get }
}
//if have mutliple endPoints we add them here
enum NewsAPI {
    case getNews
}
//we can now define our endPoint with an extension, all we are doing here is building
//the API that we are accessing
extension NewsAPI: APIBuilder {
    var baseURL: URL {
        switch self {
        case .getNews:
            return URL(string: "https://newsapi.org/v2/top-headlines?country=us&")!
        }
    }
    var path: String {
        return "apiKey=199e8836528a49c1848b82bd93e26341"
    }
    //step 2 updated URL REquest with absoulte string and printing test url 
    var urlRequest: URLRequest {
            guard let url = URL(string: self.baseURL.absoluteString.appending(self.path)) else { fatalError("no url") }
        print("\(url)")
            return URLRequest(url: url)
        }
}
