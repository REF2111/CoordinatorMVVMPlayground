//
//  RegistrationViewController.swift
//  CoordinatorPlayground
//
//  Created by Raphael Berendes on 12.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import Combine
import UIKit

class RegistrationViewController: UIViewController, LoginFlow, Storyboarded {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var firstPasswordTextField: UITextField!
    @IBOutlet weak var secondPasswordTextField: UITextField!
    @IBOutlet weak var usernameErrorLabel: UILabel!
    @IBOutlet weak var mailAddressErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var confirmationButton: UIButton!
    
    var viewModel: RegistrationViewModel!
    private var subscribers = Set<AnyCancellable>()
        
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "Registration"
        
        viewModel.usernameState
            .sink { [weak self] state in
                self?.usernameErrorLabel.isHidden = state != .error
        }.store(in: &subscribers)
        
        viewModel.mailState
            .sink { [weak self] state in
                self?.mailAddressErrorLabel.isHidden = state != .error
        }.store(in: &subscribers)
        
        viewModel.passwordState
            .sink { [weak self] state in
                switch state {
                case .input:
                    self?.passwordErrorLabel.isHidden = true
                case .invalid:
                    self?.passwordErrorLabel.text = "Invalid Password"
                    self?.passwordErrorLabel.isHidden = false
                case .equal:
                    self?.passwordErrorLabel.isHidden = true
                case .notEqual:
                    self?.passwordErrorLabel.text = "Passwords Not Equal"
                    self?.passwordErrorLabel.isHidden = false
                }
        }.store(in: &subscribers)
        
        viewModel.hasValidCredentials
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: confirmationButton)
            .store(in: &subscribers)
        
        usernameTextField.textPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.username, on: viewModel)
            .store(in: &subscribers)
        
        mailTextField.textPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.email, on: viewModel)
            .store(in: &subscribers)
        
        firstPasswordTextField.textPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.firstPassword, on: viewModel)
            .store(in: &subscribers)
        
        secondPasswordTextField.textPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.secondPassword, on: viewModel)
            .store(in: &subscribers)
    }
    
    @IBAction func didTapRegistrationButton(_ sender: UIButton) {
        viewModel.action.send(.register)
    }
    
}

