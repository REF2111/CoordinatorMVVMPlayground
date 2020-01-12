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
        case loggedIn
    }
    
    enum Action {
        case login
        case register
    }
    
    private var loginCoordinator: LoginCoordinator {
        coordinator as! LoginCoordinator
    }
        
    let state = CurrentValueSubject<State, Never>(.input)
    let action = PassthroughSubject<Action, Never>()
    @Published var username = "" { didSet { usernameSubject.send(username) }}
    @Published var  password = "" { didSet { passwordSubject.send(password) }}
    
    private let usernameSubject = PassthroughSubject<String, Never>()
    private let passwordSubject = PassthroughSubject<String, Never>()
    private var subscribers = Set<AnyCancellable>()
    
    override init(coordinator: BaseCoordinator?) {
        
        super.init(coordinator: coordinator)
                
        action
            .sink { [weak self] action in
                self?.processAction(action)
        }.store(in: &subscribers)
        
        usernameSubject
            .sink { [weak self] text in
                self?.state.send(.input)
        }.store(in: &subscribers)
        
        passwordSubject
            .sink { [weak self] text in
                self?.state.send(.input)
        }.store(in: &subscribers)
    }
        
    private func processAction(_ action: Action) {
        
        switch action {
        case .login:
            if UserManager.login(withUsername: username, andPassword: password) {
                state.send(.loggedIn)
            } else {
                state.send(.wrongCredentials)
            }
        case .register:
            loginCoordinator.showRegistration()
        }
    }
    
    private var hasValidCredentials: Bool {
        username.isValidUsername() && password.isValidPassword()
    }
    
}
