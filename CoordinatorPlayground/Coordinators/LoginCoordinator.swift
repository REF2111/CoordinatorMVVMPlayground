//
//  LoginCoordinator.swift
//  CoordinatorPlayground
//
//  Created by Raphael Berendes on 11.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import UIKit

class LoginCoordinator: BaseCoordinator {
    
    private var presentingViewController: UIViewController?
    private weak var loginViewController: LoginViewController!
    
    init(navigationController: UINavigationController?, parentCoordinator: BaseCoordinator?, presentingViewController: UIViewController?) {
        
        super.init(navigationController: navigationController, parentCoordinator: parentCoordinator)
        
        self.presentingViewController =  presentingViewController
    }
    
    override func start() {
                
        loginViewController = LoginViewController.instantiate()
        loginViewController.viewModel = LoginViewModel(coordinator: self)

        if let presentingViewController = presentingViewController {
            let loginNavigationController = UINavigationController(rootViewController: loginViewController)
            presentingViewController.present(loginNavigationController, animated: true)
        } else {
            navigationController?.pushViewController(loginViewController, animated: true)
        }
    }
    
    func showRegistration() {
        
        let vc = RegistrationViewController.instantiate()
        vc.viewModel = RegistrationViewModel(coordinator: self)
        
        let registrationNavigationController = UINavigationController(rootViewController: vc)
        loginViewController?.present(registrationNavigationController, animated: true)
    }
}
