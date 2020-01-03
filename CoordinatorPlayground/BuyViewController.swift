//
//  BuyViewController.swift
//  CoordinatorPlayground
//
//  Created by Raphael-Alexander Berendes on 03.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import UIKit

class BuyViewController: UIViewController, Storyboarded {

    weak var coordinator: MainCoordinator?

    @IBAction func didTapDetail(_ sender: Any) {
        coordinator?.showDetail()
    }
}
