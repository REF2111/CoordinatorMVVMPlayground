//
//  AppCoordinator.swift
//  CoordinatorPlayground
//
//  Created by Raphael-Alexander Berendes on 03.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import UIKit

class AppCoordinator : BaseCoordinator {
    
    override func start() {
        
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        
        store(coordinator: mainCoordinator)
        mainCoordinator.start()
    }
}
