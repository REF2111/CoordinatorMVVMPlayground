//
//  ProductsTableViewController.swift
//  CoordinatorPlayground
//
//  Created by Raphael-Alexander Berendes on 03.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import Combine
import UIKit

class ProductsTableViewController: UITableViewController, ProductFlow, Storyboarded {

    var coordinator: ProductCoordinator?
    private var products = [Product]()

    override func viewDidLoad() {

        super.viewDidLoad()

        products = Product.testProducts
        tableView.reloadData()
    }
        
    private func priceString(forProduct product: Product) -> String {
        
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
    
    private func dateString(forProduct product: Product) -> String {

        let formatter = DateFormatter()
        formatter.dateStyle = .medium

        let timestamp = Double(product.availableSince)!
        let date = Date(timeIntervalSince1970: timestamp)

        return formatter.string(from: date)
    }
    
    // MARK: TableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let product = products[indexPath.row]

        let cell = UITableViewCell()
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = """
        \(product.name)
        Price: \(priceString(forProduct: product))
        Available since: \(dateString(forProduct: product))
        """

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let product = products[indexPath.row]
        coordinator?.showDetail(product: product)
    }
}
