//
//  MainCoordinator.swift
//  CoordinatorPlayground
//
//  Created by Raphael-Alexander Berendes on 03.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import UIKit

class MainCoordinator: BaseCoordinator {
    
    override func start() {
        let vc = ViewController.instantiate()
        vc.coordinator = self
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func buy() {
        let vc = BuyTableViewController.instantiate()
        let viewModel = BuyViewModel()
        viewModel.coordinator = self
        vc.viewModel = viewModel
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func create() {
        let vc = CreateAccountViewController.instantiate()
        vc.coordinator = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showDetail(productViewModel: ProductViewModel) {
        let detailCoordinator = DetailCoordinator(navigationController: navigationController, productViewModel: productViewModel)
        detailCoordinator.delegate = self
        store(coordinator: detailCoordinator)
        detailCoordinator.start()
    }
    
}

extension MainCoordinator: CoordinatorDelegate {
    
    func didComplete(coordinator: Coordinator?) {
        
        guard let coordinator = coordinator else { return }
        
        free(coordinator: coordinator)
    }
}
