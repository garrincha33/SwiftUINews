//
//  NewsService.swift
//  SwiftUINews
//
//  Created by Richard Price on 14/04/2021.
//

import Foundation
import Combine
///return a pubblisher and listen in our view model for what we are publishing
///anypublisher allows us to subscribe and listen, similiar to result, we subscribe to whats published
///rather than get back success or familar
protocol NewsService {
    func request(from endpoint: NewsAPI) -> AnyPublisher<NewsResponse, APIError>
}
/// access the singleton shared within URLSession, dataTaskPublisher listens to the results
/// recive - on the main thread, when working with APIS as we dont want any blocking or UI out of date
/// mapError - map the error if something goes wrong
/// flat map - flatten and transform the data back from the api, publsiher expects a news response
/// erase to publsiher - convert to a publisher so we can send back this value
struct NewsServiceImplement: NewsService {
    func request(from endpoint: NewsAPI) -> AnyPublisher<NewsResponse, APIError> {
        return URLSession
            .shared
            .dataTaskPublisher(for: endpoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError { _ in APIError.unknown}
            .flatMap { data, response -> AnyPublisher<NewsResponse, APIError> in
                //check our response
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: APIError.unknown).eraseToAnyPublisher()
                }
                if(200...299).contains(response.statusCode) {
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .millisecondsSince1970
                    //decode objects
                    return Just(data)
                        .decode(type: NewsResponse.self, decoder: jsonDecoder)
                        .mapError { _ in APIError.decodingError}
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: APIError.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}
