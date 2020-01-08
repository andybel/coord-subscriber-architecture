//
//  ViewController.swift
//  Arch List PLay
//
//  Created by Andy Bell on 25.02.19.
//  Copyright © 2019 snapp mobile. All rights reserved.
//

import UIKit

final class ListViewController: UIViewController, Storyboarded {

    @IBOutlet weak var tableView: UITableView!

    public var viewModel: ListViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "articles".localized

        viewModel.subscribe { [weak self] error in

            guard let self = self else { return }
            DispatchQueue.main.async {
                guard error == nil else {
                    self.displayAlert(title: "error".localized, msg: error!.localizedDescription)
                    return
                }
                self.tableView.reloadData()
            }
        }
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfArticles()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: CellIds.LIST_CELL, for: indexPath)
        cell.textLabel?.text = viewModel.articleTitle(at: indexPath)
        return cell
    }
}

extension ListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedItem(at: indexPath)
    }
}
