//
//  NewsViewModel.swift
//  SwiftUINews
//
//  Created by Richard Price on 14/04/2021.
//

import Foundation
import Combine
//followwing on from before where we have seperated our concerns using protocols
//removing decoupling
//step 1 create a protocol which will fetch our articles
protocol NewsViewModel {
    func getArticles()
}
//step 2 use a class so we can observe changes using an obserable object
//much better for unit tests
class NewsViewModelImplement: ObservableObject, NewsViewModel {
    //dependency inject, inject our service into this class
    private let service: NewsService /// using the protocol here incase we want to create Mocks
    ///create a set of cancelables, sets dont worry about order and our quicker
    ///when we call the service we need to store the service in memory we do this with cancaeables
    private(set) var articles = [Article]()
    private var cancellables = Set<AnyCancellable>()
    @Published private(set) var state: ResultState = .loading ///default loading state is .loading

    init(service: NewsService) {
        self.service = service
    }
    //step 3 create a getArticles function
    ///sink allows us to listen for success and failures and when its finishsing publishing
    func getArticles() {
        self.state = .loading ///make sure we are loading first
        let cancellable = service.request(from: .getNews)
            .sink { res in
                switch res {
                case .finished:
                    self.state = .success(content: self.articles)
                    //send back the articles
                case .failure(let error):
                    self.state = .failed(error: error)
                    //send back an error
                }
            } receiveValue: { response in
                //when this finsihes and we have our value, put it into articles array
                self.articles = response.articles
            }
        
        //step 4 insert into our set, next load https://github.com/dmytro-anokhin/url-image into packageMa
        self.cancellables.insert(cancellable)
    }
}

