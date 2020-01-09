//
//  BuyViewModel.swift
//  CoordinatorPlayground
//
//  Created by Raphael-Alexander Berendes on 06.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import Combine
import Foundation

class BuyViewModel {

    enum Action {
        case detail(ProductViewModel)
    }

    weak var coordinator: MainCoordinator?
    let action = PassthroughSubject<Action, Never>()
    var actionCancellable: AnyCancellable?
    let productsValueSubject = CurrentValueSubject<[ProductViewModel], Never>([])

    init() {

        downloadProducts()

        actionCancellable = action.sink(receiveValue: { [weak self] action in
            self?.processAction(action)
        })
    }

    private func downloadProducts() {
        
        let products = Product.testProducts
            .map { ProductViewModel(product: $0) }
        
        productsValueSubject.send(products)
    }

    func processAction(_ action: Action) {
        switch action {
        case .detail(let product):
            coordinator?.showDetail(productViewModel: product)
        }
    }

}
