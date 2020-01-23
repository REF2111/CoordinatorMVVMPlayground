//
//  Product.swift
//  CoordinatorPlayground
//
//  Created by Raphael-Alexander Berendes on 06.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import Foundation

struct Product: Decodable {

    let name: String
    let price: Int
    let decimalPlaces: Int
    let currency: String
    let availableSince: String
    
    static var testProducts: [Product] {
        
        [
            Product(name: "MacBook", price: 229990, decimalPlaces: 2, currency: "EUR", availableSince: "1539115256"),
            Product(name: "iPhone X", price: 89000, decimalPlaces: 2, currency: "EUR", availableSince: "1505206800"),
            Product(name: "AirPods 2", price: 29999, decimalPlaces: 2, currency: "USD", availableSince: "1572426000"),
        ]
    }
}
