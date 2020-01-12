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
    
    private var cancellables = Set<AnyCancellable>()
    
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
        
        let viewModel = RegistrationViewModel(coordinator: self)
        
        registrationViewController = RegistrationViewController.instantiate()
        registrationViewController.viewModel = viewModel
        
        let registrationNavigationController = UINavigationController(rootViewController: registrationViewController)
        loginViewController?.present(registrationNavigationController, animated: true)
        
        viewModel.action
            .sink { [weak self] action in
                if action == .register {
                    self?.loginViewController.viewModel.username = viewModel.username
                    self?.loginViewController.usernameTextField.text = viewModel.username
                    self?.loginViewController.viewModel.password = viewModel.firstPassword
                    self?.loginViewController.passwordTextField.text = viewModel.firstPassword
                }
        }.store(in: &cancellables)
    }

}
