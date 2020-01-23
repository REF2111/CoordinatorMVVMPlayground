//
//  OtherTabCoordinator.swift
//  CoordinatorPlayground
//
//  Created by Raphael-Alexander Berendes on 23.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import UIKit

class OtherTabCoordinator: BaseCoordinator {

    override func start() {

        let vc = OtherTabViewController.instantiate()
        vc.title = "Other Tab"
        vc.tabBarItem = UITabBarItem(title: "Other", image: UIImage(systemName: "ellipsis.circle"), selectedImage: UIImage(systemName: "ellipsis.circle.fill"))

        navigationController?.pushViewController(vc, animated: true)
    }

}
