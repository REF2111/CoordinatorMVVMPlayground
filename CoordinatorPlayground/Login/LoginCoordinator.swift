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
    
    private var subscribers = Set<AnyCancellable>()
    
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
    
        registrationViewController = RegistrationViewController.instantiate()
        registrationViewController.viewModel = RegistrationViewModel(coordinator: self)
        let registrationNavigationController =  UINavigationController(rootViewController: registrationViewController)
        loginViewController?.present(registrationNavigationController, animated: true)
    }
            
    func didRegister(username: String, password: String) {
        
        loginViewController.viewModel.username = username
        loginViewController.usernameTextField.text = username
        loginViewController.viewModel.password = password
        loginViewController.passwordTextField.text = password
        
        registrationViewController.dismiss(animated: true)
    }

}
