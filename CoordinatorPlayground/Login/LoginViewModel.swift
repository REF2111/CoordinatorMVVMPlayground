//
//  LoginViewModel.swift
//  CoordinatorPlayground
//
//  Created by Raphael Berendes on 11.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import Combine
import UIKit

class LoginViewModel: BaseViewModel {
    
    enum State {
        case input
        case wrongCredentials
    }
    
    enum Action {
        case login
    }
    
    let state = CurrentValueSubject<State, Never>(.input)
    let action = PassthroughSubject<Action, Never>()
    @Published var username = "" { didSet { usernameSubject.send(username) }}
    @Published var  password = "" { didSet { passwordSubject.send(password) }}
    
    private let usernameSubject = PassthroughSubject<String, Never>()
    private let passwordSubject = PassthroughSubject<String, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    override init(coordinator: BaseCoordinator?) {
        
        super.init(coordinator: coordinator)
                
        action
            .sink { [weak self] action in
                self?.processAction(action)
        }.store(in: &cancellables)
        
        usernameSubject
            .sink { [weak self] text in
                self?.state.send(.input)
        }.store(in: &cancellables)
        
        passwordSubject
            .sink { [weak self] text in
                self?.state.send(.input)
        }.store(in: &cancellables)
    }
        
    private func processAction(_ action: Action) {
        
        switch action {
        case .login:
            if hasValidCredentials {
                UserManager.isUserLoggedIn = true
            } else {
                state.send(.wrongCredentials)
            }
        }
    }
    
    private var hasValidCredentials: Bool {
        username.isValidUsername() && password.isValidPassword()
    }
    
}
