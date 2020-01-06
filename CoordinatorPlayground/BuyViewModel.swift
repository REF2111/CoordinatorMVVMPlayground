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
    let products = CurrentValueSubject<[ProductViewModel], Never>([])

    init() {

        downloadProducts()

        actionCancellable = action.sink(receiveValue: { [weak self] action in
            self?.processAction(action)
        })
    }

    private func downloadProducts() {

        URLSession.shared.dataTask(with: URL(string: "http://echo.jsontest.com/name/MacBook/inches/16/timestamp/1578328080")!) { [weak self] (data, _, _) in
            guard let data = data else { return }

            do {
                let product = try JSONDecoder().decode(Product.self, from: data)
                self?.products.send([ProductViewModel(product: product)])
            } catch {
                debugPrint(error)
            }
        }.resume()
    }

    func processAction(_ action: Action) {
        switch action {
        case .detail(let product):
            coordinator?.showDetail(productViewModel: product)
        }
    }

}
