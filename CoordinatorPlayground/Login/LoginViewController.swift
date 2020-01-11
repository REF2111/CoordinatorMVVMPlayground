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
    private var cancellables = Set<AnyCancellable>()
    
    deinit {
        viewModel.didComplete()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        viewModel.state
            .sink { [weak self] state in
                switch state {
                case .input:
                    self?.errorLabel.isHidden = true
                case .wrongCredentials:
                    self?.errorLabel.isHidden = false
                }
        }.store(in: &cancellables)
                
        usernameTextField.textPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.username, on: viewModel)
            .store(in: &cancellables)
        
        passwordTextField.textPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.password, on: viewModel)
            .store(in: &cancellables)
    }
    
    @IBAction func didTapLoginButton(_ sender: UIButton) {
        viewModel.action.send(.login)
    }
    
    @IBAction func didTapRegisterButton(_ sender: UIButton) {
    }
    
}
