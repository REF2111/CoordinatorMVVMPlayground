//
//  ProductFlowViewModel.swift
//  CoordinatorPlayground
//
//  Created by Raphael Berendes on 11.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import Combine

class ProductOverviewViewModel: BaseViewModel {
    
    enum Action {
        case detail(ProductViewModel)
    }

    let action = PassthroughSubject<Action, Never>()
    private var actionSubscriber: AnyCancellable!
    let productsValueSubject = CurrentValueSubject<[ProductViewModel], Never>([])
    
    override init(coordinator: BaseCoordinator?) {
        
        super.init(coordinator: coordinator)
        
        downloadProducts()
        
        actionSubscriber = action.sink(receiveValue: { [weak self] action in
            self?.processAction(action)
        })
    }
    
    private var productCoordinator: ProductCoordinator {
        coordinator as! ProductCoordinator
    }

    private func downloadProducts() {
        
        let products = Product.testProducts
            .map { ProductViewModel(coordinator: coordinator, product: $0) }
        
        productsValueSubject.send(products)
    }
    
    private func processAction(_ action: Action) {
        
        switch action {
        case .detail(let product):
            productCoordinator.showDetail(product: product)
        }
    }

}