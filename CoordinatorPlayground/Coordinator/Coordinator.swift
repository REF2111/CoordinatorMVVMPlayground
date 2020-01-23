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
}

extension Coordinator {

    func store(coordinator: BaseCoordinator) {
        childCoordinators.append(coordinator)
    }

    func free(coordinator: BaseCoordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }

}

protocol CoordinatorDelegate: class {
    
    func didComplete(coordinator: BaseCoordinator?)
}

extension CoordinatorDelegate {
    
    func didComplete(coordinator: BaseCoordinator?) {
        guard let coordinator = coordinator else { return }
        
        coordinator.parentCoordinator?.free(coordinator: coordinator)
    }
}
