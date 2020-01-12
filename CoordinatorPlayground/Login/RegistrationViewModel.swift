//
//  RegistrationViewModel.swift
//  CoordinatorPlayground
//
//  Created by Raphael Berendes on 12.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import Combine

class RegistrationViewModel: BaseViewModel {
    
    enum Action {
        case register
    }
    
    enum State {
        case input
        case registered
    }
    
    enum UsernameState {
        case input
        case valid
        case error
    }
    
    enum MailState {
        case input
        case valid
        case error
    }
    
    enum PasswordState {
        case input
        case invalid
        case equal
        case notEqual
    }
    
    private var loginCoordinator: LoginCoordinator {
        coordinator as! LoginCoordinator
    }
    
    let action = PassthroughSubject<Action, Never>()
    let state = CurrentValueSubject<State, Never>(.input)
    let usernameState = CurrentValueSubject<UsernameState, Never>(.input)
    let mailState = CurrentValueSubject<MailState, Never>(.input)
    let passwordState = CurrentValueSubject<PasswordState, Never>(.input)
    let hasValidCredentials = CurrentValueSubject<Bool, Never>(false)

    @Published var username = "" { didSet { usernameSubject.send(username) }}
    @Published var email = "" { didSet { emailSubject.send(email) }}
    @Published var  firstPassword = "" { didSet { firstPasswordSubject.send(firstPassword) }}
    @Published var  secondPassword = "" { didSet { secondPasswordSubject.send(secondPassword) }}
    
    private let usernameSubject = PassthroughSubject<String, Never>()
    private let emailSubject = PassthroughSubject<String, Never>()
    private let firstPasswordSubject = PassthroughSubject<String, Never>()
    private let secondPasswordSubject = PassthroughSubject<String, Never>()
    
    private var cancellables = Set<AnyCancellable>()
    
    override init(coordinator: BaseCoordinator?) {
        
        super.init(coordinator: coordinator)
        
        action
            .sink { [weak self] action in
                self?.processAction(action)
        }.store(in: &cancellables)
        
        usernameSubject
            .sink { [weak self] text in
                self?.usernameState.send(text.isValidUsername() ? .valid: .error)
        }.store(in: &cancellables)
        
        emailSubject
            .sink { [weak self] text in
                self?.mailState.send(text.isValidMailAddress() ? .valid: .error)
        }.store(in: &cancellables)
        
        firstPasswordSubject
            .sink { [weak self] text in
                self?.processPasswords(first: text, second: String())
        }.store(in: &cancellables)
        
        Publishers.CombineLatest(firstPasswordSubject, secondPasswordSubject)
            .sink { [weak self] (first: String, second: String) in
                self?.processPasswords(first: first, second: second)
        }.store(in: &cancellables)
        
        Publishers.CombineLatest3(usernameState, mailState, passwordState)
            .map { (nameState: UsernameState,
                mailState: MailState,
                passwordState: PasswordState) -> Bool in
                nameState == .valid && mailState == .valid && passwordState == .equal
        }
        .subscribe(hasValidCredentials)
        .store(in: &cancellables)
    }
    
    private func processAction(_ action: Action) {
        
        switch action {
        case .register:
            UserManager.register(withUsername: username, andPassword: firstPassword)
            state.send(.registered)
        }
    }
        
    private func processPasswords(first: String, second: String) {
        
        if first.isEmpty && second.isEmpty {
            passwordState.send(.input)
            return
        }
        
        if !first.isValidPassword() {
            passwordState.send(.invalid)
            return
        }
        
        if second.isEmpty {
            passwordState.send(.input)
            return
        } else if first != second {
            passwordState.send(.notEqual)
            return
        }
        
        passwordState.send(.equal)
    }
        
}
