//
//  ListViewModel.swift
//  Arch List PLay
//
//  Created by Andy Bell on 25.02.19.
//  Copyright © 2019 snapp mobile. All rights reserved.
//

import Foundation

protocol ListViewModelProtocol {
    func subscribe(with updateCallback: ViewModelCallback)
    func numberOfArticles() -> Int
    func articleTitle(at indexPath: IndexPath) -> String
    func selectedItem(at indexPath: IndexPath)
}

final class ListViewModel {

    public var listSelectedArticleId: ((_: Int) -> Void) = { _ in print("listSelectedArticleId not overriden") }

    private var updateCallback: ViewModelCallback = nil
    private var articles = [Article]()

    private let listService: ListLoadServiceProtocol

    init(with listService: ListLoadService) {
        self.listService = listService
    }

    private func loadArticles() {

        listService.loadArticlesList { [weak self] result in

            guard let self = self else { return }
            switch result {
            case .success(let articles):
                self.articles = articles
                self.updateCallback?(nil)
            case .failure(let err):
                self.updateCallback?(err)
            }
        }
    }
}

extension ListViewModel: ListViewModelProtocol {

    func subscribe(with updateCallback: ViewModelCallback) {
        self.updateCallback = updateCallback
        loadArticles()
    }

    func numberOfArticles() -> Int {
        return articles.count
    }

    func articleTitle(at indexPath: IndexPath) -> String {
        return articles[indexPath.row].title
    }

    func selectedItem(at indexPath: IndexPath) {
        let articleId = articles[indexPath.row].id
        listSelectedArticleId(articleId)
    }
}
