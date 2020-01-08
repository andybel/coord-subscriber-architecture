//
//  ListLoadService.swift
//  Arch List PLay
//
//  Created by Andy Bell on 25.02.19.
//  Copyright © 2019 snapp mobile. All rights reserved.
//

import Foundation

protocol ListLoadServiceProtocol {
    func loadArticlesList(completion: @escaping  ((_: Result<[Article]>) -> Void))
}

final class ListLoadService: ListLoadServiceProtocol {

    private let coreAPi: CoreApiProtocol

    init(api: CoreApiProtocol = CoreApiLive()) {
        self.coreAPi = api
    }

    func loadArticlesList(completion: @escaping ((Result<[Article]>) -> Void)) {

        coreAPi.performRequest(for: CoreApiURL.loadList) { (data, _, error) in

            guard error == nil else {
                completion(.failure(error!))
                return
            }
            CoreDecoder.decodeFrom(data: data, completion: completion)
        }
    }
}
