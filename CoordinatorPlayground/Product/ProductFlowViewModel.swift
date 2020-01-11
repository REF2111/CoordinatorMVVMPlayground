//
//  ProductFlowViewModel.swift
//  CoordinatorPlayground
//
//  Created by Raphael Berendes on 11.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import Combine

class ProductFlowViewModel: BaseViewModel {
    
    enum Action {
        case detail(ProductViewModel)
    }

    let action = PassthroughSubject<Action, Never>()
    private var actionCancellable: AnyCancellable!
    let productsValueSubject = CurrentValueSubject<[ProductViewModel], Never>([])
    
    override init(coordinator: BaseCoordinator?) {
        
        super.init(coordinator: coordinator)
        
        downloadProducts()
        
        actionCancellable = action.sink(receiveValue: { [weak self] action in
            self?.processAction(action)
        })
    }

    private func downloadProducts() {
        
        let products = Product.testProducts
            .map { ProductViewModel(coordinator: coordinator, product: $0) }
        
        productsValueSubject.send(products)
    }
    
    private func processAction(_ action: Action) {
        
        switch action {
        case .detail(let product):
            (coordinator as? ProductCoordinator)?.showDetail(product: product)
        }
    }

}
