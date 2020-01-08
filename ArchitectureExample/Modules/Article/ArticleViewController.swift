//
//  ArticleViewController.swift
//  Arch List PLay
//
//  Created by Andy Bell on 25.02.19.
//  Copyright © 2019 snapp mobile. All rights reserved.
//

import UIKit

final class ArticleViewController: UIViewController, Storyboarded {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainTextView: UITextView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!

    public weak var coordinator: ArticleCoordinator?
    public var viewModel: ArticleViewModelProtocol!
    public var commentsBarBtn: UIBarButtonItem?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupInitialUI()

        viewModel.subscribe { [weak self] error in

            guard let self = self else { return }
            DispatchQueue.main.async {
                guard error == nil else {
                    self.displayAlert(title: "error".localized, msg: error!.localizedDescription)
                    return
                }
                self.updateUI()
            }
        }
    }

    private func setupInitialUI() {

        title = "article".localized
        titleLabel.text = ""
        mainTextView.text = ""
        spinner.startAnimating()
    }

    private func updateUI() {

        spinner.stopAnimating()

        self.titleLabel.text = viewModel.articleTitle()
        self.mainTextView.text = viewModel.articleBody()

        let btnTitle = String(format: "comments_count".localized, viewModel.commentsCount())
        commentsBarBtn = UIBarButtonItem(title: btnTitle, style: .plain, target: self, action: #selector(commentsBtnTapped(_:)))
        self.navigationItem.setRightBarButton(commentsBarBtn, animated: true)
    }

    @IBAction func commentsBtnTapped(_ sender: UIBarButtonItem) {
        displayAlert(title: "alert", msg: "TODO: display the comments list")
    }
}
