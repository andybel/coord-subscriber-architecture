//
//  ArticleCoordinator.swift
//  Arch List PLay
//
//  Created by Andy Bell on 26.02.19.
//  Copyright © 2019 snapp mobile. All rights reserved.
//

import UIKit

class ArticleCoordinator: Coordinator {

    weak var parentCoordinator: MainCoordinator?

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    private let articleId: Int

    init(navigationController: UINavigationController, articleId: Int) {
        self.navigationController = navigationController
        self.articleId = articleId
    }

    func start() {
        let vc = ArticleViewController.instantiate()
        let vm = ArticleViewModel(with: ArticleService(), articleId: articleId)
        vc.viewModel = vm
        navigationController.pushViewController(vc, animated: true)
    }
}
