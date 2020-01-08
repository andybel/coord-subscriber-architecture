//
//  ArticleViewModel.swift
//  Arch List PLay
//
//  Created by Andy Bell on 25.02.19.
//  Copyright © 2019 snapp mobile. All rights reserved.
//

import Foundation

protocol ArticleViewModelProtocol {
    func subscribe(with updateCallback: ViewModelCallback)
    func articleTitle() -> String
    func articleBody() -> String
    func commentsCount() -> Int
}

final class ArticleViewModel {

    private var updateCallback: ViewModelCallback = nil
    private var article: Article?
    private var articleCommentsCount = 0

    private let articleService: ArticleServiceProtocol
    private let articleId: Int

    init(with articleService: ArticleServiceProtocol, articleId: Int) {
        self.articleService = articleService
        self.articleId = articleId
    }

    private func loadArticle() {

        articleService.loadArticleWithId(articleId) { [weak self] result in

            guard let self = self else { return }
            switch result {
            case .success(let article):
                self.article = article
                self.loadComments()
            case .failure(let error):
                self.updateCallback?(error)
            }
        }
    }

    private func loadComments() {

        articleService.loadArticleCommentsWithId(self.articleId) { [weak self] result in

            guard let self = self else { return }
            switch result {
            case .success(let comments):
                self.articleCommentsCount = comments.count
                self.updateCallback?(nil)
            case .failure(let error):
                self.updateCallback?(error)
            }
        }
    }
}

extension ArticleViewModel: ArticleViewModelProtocol {

    func subscribe(with updateCallback: ViewModelCallback) {
        self.updateCallback = updateCallback
        loadArticle()
    }

    func articleTitle() -> String {
        return article?.title ?? "article".localized
    }

    func articleBody() -> String {
        return article?.body ?? ""
    }

    func commentsCount() -> Int {
        return articleCommentsCount
    }
}
