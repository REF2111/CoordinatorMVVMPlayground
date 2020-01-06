//
//  MainCoordinator.swift
//  CoordinatorPlayground
//
//  Created by Raphael-Alexander Berendes on 03.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import UIKit

class MainCoordinator: BaseCoordinator {

    private var navigationController: UINavigationController
    private var detailCoordinator: DetailCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    override func start() {
        let vc = ViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }

    func buy() {
        let vc = BuyTableViewController.instantiate()
        vc.coordinator = self
        vc.viewModel = BuyViewModel()
        navigationController.pushViewController(vc, animated: true)
    }

    func create() {
        let vc = CreateAccountViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }

    func showDetail() {
        detailCoordinator = DetailCoordinator(navigationController: navigationController)
        store(coordinator: detailCoordinator!)
        detailCoordinator?.start()

        detailCoordinator?.isCompleted = { [weak self] in
            guard let detailCoordinator = self?.detailCoordinator else { return }
            self?.free(coordinator: detailCoordinator)
            self?.detailCoordinator = nil
        }

    }

}
