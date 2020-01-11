//
//  LoginCoordinator.swift
//  CoordinatorPlayground
//
//  Created by Raphael Berendes on 11.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import UIKit

class LoginCoordinator: BaseCoordinator {
    
    private var viewController: UIViewController!
    
    init(navigationController: UINavigationController?, parentCoordinator: BaseCoordinator?, viewController: UIViewController) {
        
        super.init(navigationController: navigationController, parentCoordinator: parentCoordinator)
        
        self.viewController =  viewController
    }
    
    override func start() {
        
        let vc = LoginViewController.instantiate()
        vc.viewModel = LoginViewModel(coordinator: self)
        viewController.present(vc, animated: true)
    }
}
