//
//  TabBarController.swift
//  CoordinatorPlayground
//
//  Created by Raphael Berendes on 11.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, MainFlow, Storyboarded {

    let productCoordinator = ProductCoordinator(navigationController: UINavigationController(), parentCoordinator: nil)
    let otherTabCoordinator = OtherTabCoordinator(navigationController: UINavigationController(), parentCoordinator: nil)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        productCoordinator.start()
        otherTabCoordinator.start()
        viewControllers = [
            productCoordinator.navigationController,
            otherTabCoordinator.navigationController
        ]
    }
}
