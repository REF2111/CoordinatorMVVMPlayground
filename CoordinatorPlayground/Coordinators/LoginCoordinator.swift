//
//  LoginCoordinator.swift
//  CoordinatorPlayground
//
//  Created by Raphael Berendes on 11.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import UIKit

class LoginCoordinator: BaseCoordinator {
    
    override func start() {
        
        let vc = UIViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
