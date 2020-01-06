//
//  ProductViewModel.swift
//  CoordinatorPlayground
//
//  Created by Raphael-Alexander Berendes on 06.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import Foundation

class ProductViewModel {

    private var product: Product!

    init(product: Product) {
        self.product = product
    }

    var name: String {
        product.name
    }

    var inches: String {
        product.inches
    }

    var dateFormatted: String {

        let formatter = DateFormatter()
        formatter.dateStyle = .medium

        let timestamp = Double(product.timestamp)!
        let date = Date(timeIntervalSince1970: timestamp)

        return formatter.string(from: date)
    }
}
