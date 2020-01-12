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
    
    var viewModel: LoginViewModel!
    private var subscribers = Set<AnyCancellable>()
    
    deinit {
        viewModel.didComplete()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "Login"
        
        viewModel.state
            .sink { [weak self] state in
                switch state {
                case .input:
                    self?.errorLabel.isHidden = true
                case .wrongCredentials:
                    self?.errorLabel.isHidden = false
                case .loggedIn:
                    self?.dismiss(animated: true)
                }
        }.store(in: &subscribers)
                
        usernameTextField.textPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.username, on: viewModel)
            .store(in: &subscribers)
        
        passwordTextField.textPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.password, on: viewModel)
            .store(in: &subscribers)
    }
    
    @IBAction func didTapLoginButton(_ sender: UIButton) {
        viewModel.action.send(.login)
    }
    
    @IBAction func didTapRegisterButton(_ sender: UIButton) {
        viewModel.action.send(.register)
    }
    
}
