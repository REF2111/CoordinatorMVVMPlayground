//
//  BaseCoordinator.swift
//  CoordinatorPlayground
//
//  Created by Raphael-Alexander Berendes on 03.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import UIKit

protocol CoordinatorDelegate: class {
    func didComplete(coordinator: Coordinator?)
}

class BaseCoordinator: Coordinator {
    
    weak var navigationController: UINavigationController?
    weak var delegate: CoordinatorDelegate?
    var childCoordinators : [Coordinator] = []
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    func start() {
        fatalError("Children should implement `start`.")
    }

}
