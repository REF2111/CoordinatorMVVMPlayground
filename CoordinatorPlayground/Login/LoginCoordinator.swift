//
//  LoginCoordinator.swift
//  CoordinatorPlayground
//
//  Created by Raphael Berendes on 11.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import Combine
import UIKit

class LoginCoordinator: BaseCoordinator {
    
    private var presentingViewController: UIViewController?
    private weak var loginViewController: LoginViewController!
    private weak var registrationViewController: RegistrationViewController!
    
    init(navigationController: UINavigationController, parentCoordinator: BaseCoordinator?, presentingViewController: UIViewController?) {
        
        super.init(navigationController: navigationController, parentCoordinator: parentCoordinator)
        
        self.presentingViewController =  presentingViewController
    }
    
    override func start() {
        
        loginViewController = LoginViewController.instantiate()
        loginViewController.coordinator = self
        
        if let presentingViewController = presentingViewController {
            let loginNavigationController = UINavigationController(rootViewController: loginViewController)
            presentingViewController.present(loginNavigationController, animated: true)
        } else {
            navigationController.pushViewController(loginViewController, animated: true)
        }
    }
    
    func showRegistration() {
        
        registrationViewController = RegistrationViewController.instantiate()
        let registrationNavigationController =  UINavigationController(rootViewController: registrationViewController)
        loginViewController?.present(registrationNavigationController, animated: true)
    }
    
}
