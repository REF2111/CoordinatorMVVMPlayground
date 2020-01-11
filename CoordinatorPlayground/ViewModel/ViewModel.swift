//
//  ViewModel.swift
//  CoordinatorPlayground
//
//  Created by Raphael Berendes on 11.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import Foundation

protocol ViewModel {
    
    var coordinator: BaseCoordinator? { get set }
    func didComplete()
}

extension ViewModel {
    
    func didComplete() {
        
        coordinator?.parentCoordinator?.didComplete(coordinator: coordinator)
    }
}
