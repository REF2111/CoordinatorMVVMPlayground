//
//  LoginViewController.swift
//  CoordinatorPlayground
//
//  Created by Raphael Berendes on 11.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, LoginFlow, Storyboarded {

    var viewModel: LoginViewModel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

    }
    
    deinit {
        viewModel.didComplete()
    }

}
