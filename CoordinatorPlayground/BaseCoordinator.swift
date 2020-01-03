//
//  BaseCoordinator.swift
//  CoordinatorPlayground
//
//  Created by Raphael-Alexander Berendes on 03.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import Foundation

class BaseCoordinator: Coordinator {
    
    var childCoordinators : [Coordinator] = []
    var isCompleted: (() -> ())?

    func start() {
        fatalError("Children should implement `start`.")
    }

}
