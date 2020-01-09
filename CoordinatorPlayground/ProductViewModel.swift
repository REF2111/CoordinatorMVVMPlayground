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
    weak var coordinator: DetailCoordinator?

    init(product: Product) {
        self.product = product
    }
    
    func didComplete() {
        coordinator?.delegate?.didComplete(coordinator: coordinator)
    }

    var name: String {
        product.name
    }

    var priceString: String {
        
        var price = Float(product.price)
        let decimalPlaces = Float(product.decimalPlaces)
        
        if product.decimalPlaces != .zero {
            price = price / powf(10, decimalPlaces)
        }
        
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .currency
        formatter.currencyCode = product.currency
        formatter.minimumFractionDigits = product.decimalPlaces
        formatter.maximumFractionDigits = product.decimalPlaces
        
        return formatter.string(for: price) ?? formatter.string(for: 0)!
    }

    var dateString: String {

        let formatter = DateFormatter()
        formatter.dateStyle = .medium

        let timestamp = Double(product.availableSince)!
        let date = Date(timeIntervalSince1970: timestamp)

        return formatter.string(from: date)
    }
}
