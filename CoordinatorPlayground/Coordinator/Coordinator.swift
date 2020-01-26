//
//  Coordinator.swift
//  CoordinatorPlayground
//
//  Created by Raphael-Alexander Berendes on 03.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import UIKit

protocol Coordinator: class {

    var parentCoordinator: BaseCoordinator? { get set }
    var childCoordinators: [BaseCoordinator] { get set }
    func start()
    func didComplete()
}

extension Coordinator {

    func store(coordinator: BaseCoordinator) {
        childCoordinators.append(coordinator)
    }

    func free(coordinator: BaseCoordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
    
    func didComplete() {
        self.parentCoordinator?.free(coordinator: self as! BaseCoordinator)
    }

}
