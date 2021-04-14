//
//  ArticleView.swift
//  SwiftUINews
//
//  Created by Richard Price on 14/04/2021.
//

import SwiftUI
import URLImage
struct ArticleView: View {
    
    let article: Article
    
    var body: some View {
        //MARK: Article Image
        HStack {
            if let imageURL = article.image,
               let url = URL(string: imageURL) {
                URLImage(url: url,
                         options: URLImageOptions(
                            identifier: article.id.uuidString,
                            cachePolicy: .returnCacheElseLoad(cacheDelay: nil, downloadDelay: 0.25)
                         ),
                         failure: { error, _ in
                            PlaceholderImageView()
                         },
                         content: { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                         })
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
            } else {
                PlaceholderImageView()
            }
            //MARK:- Article Text
            VStack(alignment: .leading, spacing: 4) {
                Text(article.title ?? "")
                    .foregroundColor(.black)
                    .font(.system(size: 18, weight: .semibold))
                Text(article.source ?? "N/A")
                    .foregroundColor(Color.gray)
                    .font(.footnote)
            }
        }
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView(article: Article.dummyData)
            .previewLayout(.sizeThatFits)
    }
}
struct PlaceholderImageView: View {
    var body: some View {
        Image(systemName: "photo.fill")
            .foregroundColor(Color.white)
            .background(Color.gray)
            .frame(width: 100, height: 100)
    }
}
