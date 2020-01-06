//
//  DetailViewController.swift
//  CoordinatorPlayground
//
//  Created by Raphael-Alexander Berendes on 03.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, Storyboarded {

    weak var coordinator: DetailCoordinator?

    override func viewDidLoad() {

        super.viewDidLoad()

        title = "Detail"
    }

    deinit {
        coordinator?.isCompleted?()
    }
}
