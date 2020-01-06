//
//  DetailCoordinator.swift
//  CoordinatorPlayground
//
//  Created by Raphael-Alexander Berendes on 03.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import UIKit

class DetailCoordinator: BaseCoordinator {

    private var navigationController: UINavigationController
    private var viewModel: ProductViewModel

    init(navigationController: UINavigationController, productViewModel: ProductViewModel) {
        self.navigationController = navigationController
        self.viewModel = productViewModel
    }

    override func start() {
        let vc = DetailViewController.instantiate()
        viewModel.coordinator = self
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
}
