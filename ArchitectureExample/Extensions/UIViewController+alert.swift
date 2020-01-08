//
//  UIViewController+alert.swift
//  Arch List PLay
//
//  Created by Andy Bell on 26.02.19.
//  Copyright © 2019 snapp mobile. All rights reserved.
//

import UIKit

extension UIViewController {

    func displayAlert(title: String, msg: String, completion: (() -> Void)? = nil) {
        let alertVC = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "cancel".localized, style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: completion)
    }
}
