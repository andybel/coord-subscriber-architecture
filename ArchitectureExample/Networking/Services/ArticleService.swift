//
//  ArticleService.swift
//  Arch List PLay
//
//  Created by Andy Bell on 25.02.19.
//  Copyright © 2019 snapp mobile. All rights reserved.
//

import Foundation

protocol ArticleServiceProtocol {
    func loadArticleWithId(_ articleId: Int, completion: @escaping  ((_: Result<Article>) -> Void))
    func loadArticleCommentsWithId(_ articleId: Int, completion: @escaping  ((_: Result<[Comment]>) -> Void))
}

final class ArticleService: ArticleServiceProtocol {

    private let coreAPi: CoreApiProtocol

    init(api: CoreApiProtocol = CoreApiLive()) {
        self.coreAPi = api
    }

    func loadArticleWithId(_ articleId: Int, completion: @escaping ((Result<Article>) -> Void)) {

        coreAPi.performRequest(for: CoreApiURL.articleById(articleId)) { (data, _, error) in

            guard error == nil else {
                completion(.failure(error!))
                return
            }
            CoreDecoder.decodeFrom(data: data, completion: completion)
        }
    }

    func loadArticleCommentsWithId(_ articleId: Int, completion: @escaping ((Result<[Comment]>) -> Void)) {

        coreAPi.performRequest(for: CoreApiURL.articleCommentsById(articleId)) { (data, _, error) in

            guard error == nil else {
                completion(.failure(error!))
                return
            }
            CoreDecoder.decodeFrom(data: data, completion: completion)
        }
    }
}
