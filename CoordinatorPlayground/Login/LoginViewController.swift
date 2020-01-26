//
//  LoginViewController.swift
//  CoordinatorPlayground
//
//  Created by Raphael Berendes on 11.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import Combine
import UIKit

class LoginViewController: UIViewController, LoginFlow, Storyboarded {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    var coordinator: LoginCoordinator!
    
    deinit {
        coordinator.parentCoordinator?.didComplete(coordinator: coordinator)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "Login"
    }
    
    @IBAction func didTapLoginButton(_ sender: UIButton) {
        UserManager.isUserLoggedIn = true
        dismiss(animated: true)
    }
    
    @IBAction func didTapRegisterButton(_ sender: UIButton) {
        coordinator.showRegistration()
    }
    
}
