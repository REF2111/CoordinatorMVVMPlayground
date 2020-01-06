//
//  ViewController.swift
//  CoordinatorPlayground
//
//  Created by Raphael-Alexander Berendes on 03.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Storyboarded {

    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {

        super.viewDidLoad()

        title = "Main"
    }

    @IBAction func didTapBuy(_ sender: Any) {
        coordinator?.buy()
    }

    @IBAction func didTapCreate(_ sender: Any) {
        coordinator?.create()
    }

}

