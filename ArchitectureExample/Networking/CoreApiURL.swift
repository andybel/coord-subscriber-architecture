//
//  CoreApiURL.swift
//  Arch List PLay
//
//  Created by Andy Bell on 25.02.19.
//  Copyright © 2019 snapp mobile. All rights reserved.
//

import Foundation

enum CoreApiURL {

    case loadList
    case articleById(Int)
    case articleCommentsById(Int)

    func url() -> URL {
        guard let coreUrl = URL(string: self.urlStr()) else {
            fatalError("failed to generate url for \(self)")
        }
        return coreUrl
    }

    private func urlStr() -> String {
        let base = "https://jsonplaceholder.typicode.com/"

        switch self {
        case .loadList:
            return base + "posts"
        case .articleById(let articleId):
            return base + "posts/" + String(articleId)
        case .articleCommentsById(let articleId):
            return base + "comments?postId=" + String(articleId)
        }
    }
}

extension CoreApiURL {

    func mockFileName() -> String {
        switch self {
        case .loadList:
            return "loadList"
        case .articleById:
            return "loadArticle"
        case .articleCommentsById:
            return "articleComments"
        }
    }
}
