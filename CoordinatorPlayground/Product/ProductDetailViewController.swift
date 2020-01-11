//
//  ProductDetailViewController.swift
//  CoordinatorPlayground
//
//  Created by Raphael-Alexander Berendes on 03.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController, Storyboarded {

    var viewModel: ProductViewModel!

    override func viewDidLoad() {

        super.viewDidLoad()

        title = viewModel.name
    }

    deinit {
        print("HALLO")
    }
}
