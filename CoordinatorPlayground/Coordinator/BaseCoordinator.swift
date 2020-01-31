//
//  BaseCoordinator.swift
//  CoordinatorPlayground
//
//  Created by Raphael-Alexander Berendes on 03.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import UIKit

class BaseCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var parentCoordinator: BaseCoordinator?
    var childCoordinators : [BaseCoordinator] = []
    
    init(navigationController: UINavigationController, parentCoordinator: BaseCoordinator?) {
        
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }

    func start() {
        fatalError("Children should implement `start`.")
    }

}
