//
//  DetailCoordinator.swift
//  CoordinatorPlayground
//
//  Created by Raphael-Alexander Berendes on 03.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import UIKit

class DetailCoordinator: BaseCoordinator {

    private var viewModel: ProductViewModel

    init(navigationController: UINavigationController?, productViewModel: ProductViewModel) {
        self.viewModel = productViewModel
        super.init(navigationController: navigationController)
    }

    override func start() {
        let vc = DetailViewController.instantiate()
        viewModel.coordinator = self
        vc.viewModel = viewModel
        navigationController?.pushViewController(vc, animated: true)
    }
}
