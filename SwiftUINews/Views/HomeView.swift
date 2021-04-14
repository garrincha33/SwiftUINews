//
//  HomeView.swift
//  SwiftUINews
//
//  Created by Richard Price on 13/04/2021.
//

import SwiftUI

struct HomeView: View {
    //step 3 add reference to view model
    @StateObject var viewModel = NewsViewModelImplement(service: NewsServiceImplement())
    
    var body: some View {
        //step 4 create a group and attach onAppear call view model
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .failed(let error):
                ErrorView(error: error, handler: viewModel.getArticles)
            case .success(let articles):
                NavigationView {
                    List(articles) {item in
                        ArticleView(article: item)
                    }
                    .navigationTitle(Text("News"))
                }
            }
        }.onAppear(perform: viewModel.getArticles)
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
