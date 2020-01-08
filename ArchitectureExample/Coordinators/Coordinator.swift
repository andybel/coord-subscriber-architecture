//
//  Coordinator.swift
//  Arch List PLay
//
//  Created by Andy Bell on 25.02.19.
//  Copyright © 2019 snapp mobile. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
