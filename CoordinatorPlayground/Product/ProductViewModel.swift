//
//  ProductViewModel.swift
//  CoordinatorPlayground
//
//  Created by Raphael-Alexander Berendes on 06.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import Combine
import Foundation

class ProductViewModel: BaseViewModel {
    
    private var product: Product!
    
    init(coordinator: BaseCoordinator?, product: Product) {
        
        super.init(coordinator: coordinator)
        
        self.product = product
    }
    
    private var productCoordiantor: ProductCoordinator {
        coordinator as! ProductCoordinator
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
    
    func buy() {
        
        productCoordiantor.buy(product: product, completion: { success in
            print(success)
        })
    }
    
}
