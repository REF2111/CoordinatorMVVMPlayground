//
//  ProductCoordinator.swift
//  CoordinatorPlayground
//
//  Created by Raphael Berendes on 11.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import UIKit

class ProductCoordinator: BaseCoordinator {
        
    override func start() {
        
        let vc = ProductsTableViewController.instantiate()
        vc.viewModel = ProductFlowViewModel(coordinator: self)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showDetail(product: ProductViewModel) {
        
        let vc = ProductDetailTableViewController.instantiate()
        vc.viewModel = product
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func buy(product: Product, completion: (_ success: Bool) -> Void) {
                
        if UserManager.isUserLoggedIn {
            completion(true)
        } else {
            startLoginFlow()
        }
    }
    
    func startLoginFlow() {
        
        guard let viewController = navigationController?.topViewController else { return }
        
        let loginCoordinator = LoginCoordinator(navigationController: navigationController, parentCoordinator: self, viewController: viewController)
        store(coordinator: loginCoordinator)
        
        loginCoordinator.start()
    }

}
