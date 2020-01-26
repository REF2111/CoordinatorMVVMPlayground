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
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "Registration"
    }
    
    @IBAction func didTapRegistrationButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}

