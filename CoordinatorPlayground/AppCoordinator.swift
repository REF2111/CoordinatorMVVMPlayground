//
//  AppCoordinator.swift
//  CoordinatorPlayground
//
//  Created by Raphael-Alexander Berendes on 03.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import UIKit

class AppCoordinator : BaseCoordinator {

    let window : UIWindow

    init(window: UIWindow) {
        self.window = window
        super.init()
    }

    override func start() {
        // preparing root view
        let navigationController = UINavigationController()
        let mainCoordinator = MainCoordinator(navigationController: navigationController)

        // store child coordinator
        self.store(coordinator: mainCoordinator)
        mainCoordinator.start()

        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        // detect when free it
        mainCoordinator.isCompleted = { [weak self] in
            self?.free(coordinator: mainCoordinator)
        }
    }
}
