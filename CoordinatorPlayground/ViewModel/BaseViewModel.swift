//
//  BaseViewModel.swift
//  CoordinatorPlayground
//
//  Created by Raphael Berendes on 11.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import Foundation

class BaseViewModel: ViewModel {
    
    var coordinator: BaseCoordinator?
    
    init(coordinator: BaseCoordinator?) {
        self.coordinator = coordinator
    }
}
