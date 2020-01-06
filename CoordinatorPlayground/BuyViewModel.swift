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

    var products = CurrentValueSubject<[ProductViewModel], Never>([])

    init() {
        downloadProducts()
    }

    private func downloadProducts() {

        URLSession.shared.dataTask(with: URL(string: "http://echo.jsontest.com/name/MacBook/inches/16/timestamp/1578328080")!) { [weak self] (data, _, _) in
            guard let data = data else { return }

            do {
                let product = try JSONDecoder().decode(Product.self, from: data)
                self?.products.value = [ProductViewModel(product: product)]
            } catch {
                debugPrint(error)
            }
        }.resume()
    }

}
