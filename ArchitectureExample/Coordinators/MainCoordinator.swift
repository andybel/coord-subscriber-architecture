//
//  MainCoordinator.swift
//  Arch List PLay
//
//  Created by Andy Bell on 25.02.19.
//  Copyright © 2019 snapp mobile. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = ListViewController.instantiate()

        let listService = ListLoadService(api: CoreApiLive())
        let listViewModel = ListViewModel(with: listService)
        listViewModel.listSelectedArticleId = { [weak self] id in
            self?.displayArticleWithId(id)
        }
        vc.viewModel = listViewModel

        navigationController.pushViewController(vc, animated: false)
    }

    private func displayArticleWithId(_ articleId: Int) {
        let child = ArticleCoordinator(navigationController: navigationController, articleId: articleId)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }

    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {

        guard let fromVC = navigationController.transitionCoordinator?.viewController(forKey: .from),
            navigationController.viewControllers.contains(fromVC),
            let articleVC = fromVC as? ArticleViewController else {
                return
        }
        childDidFinish(articleVC.coordinator)
    }
}
