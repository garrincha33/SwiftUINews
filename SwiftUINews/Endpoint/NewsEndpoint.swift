//
//  NewsEndpoint.swift
//  SwiftUINews
//
//  Created by Richard Price on 14/04/2021.
//

import Foundation

//step 2 create an endpoint using a protocol builder, protocols are good for reusability
protocol APIBuilder {
    var urlRequest: URLRequest { get }
    var baseURL: URL { get }
    var path: String { get }
}
//if have mutliple endPoints we add them here
enum NewsAPI {
    case getNews
}
//step 3 we can now define our endPoint with an extension, all we are doing here is building
//the API that we are accessing
extension NewsAPI: APIBuilder {
    var baseURL: URL {
        switch self {
        case .getNews:
            return URL(string: "https://api.lil.software")!
        }
    }
    var path: String {
        return "/news"
    }
    var urlRequest: URLRequest {
        return URLRequest(url: self.baseURL.appendingPathComponent(self.path))
    }
}
