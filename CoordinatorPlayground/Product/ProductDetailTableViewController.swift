//
//  ProductDetailViewController.swift
//  CoordinatorPlayground
//
//  Created by Raphael-Alexander Berendes on 03.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import UIKit

class ProductDetailTableViewDataSource {
    
    enum Section: Int, CaseIterable {
        case product
        case buy
    }
    
    enum ProductInfo: Int {
        case name
        case price
        case availableSince
    }
    
    private var product: Product!
    
    init(product: Product) {
        self.product = product
    }
    
    var numberOfSections: Int {
        Section.allCases.count
    }
    
    func numberOfRows(inSection section: Int) -> Int {
        
        switch Section(rawValue: section)! {
        case .product:
            return 3
        case .buy:
            return 1
        }
    }
}

class ProductDetailTableViewController: UITableViewController, ProductFlow, Storyboarded {
    
    private var dataSource: ProductDetailTableViewDataSource!
    var coordinator: ProductCoordinator?
    var product: Product!
        
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = product.name
        
        self.dataSource = ProductDetailTableViewDataSource(product: product)
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        dataSource.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.numberOfRows(inSection: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch ProductDetailTableViewDataSource.Section(rawValue: indexPath.section)! {
        case .product:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProductDetailCell.self), for: indexPath) as! ProductDetailCell
            
            switch ProductDetailTableViewDataSource.ProductInfo(rawValue: indexPath.row)! {
            case .name:
                cell.textLabel?.text = product.name
            case .price:
                cell.textLabel?.text = priceString(forProduct: product)
            case .availableSince:
                cell.textLabel?.text = dateString(forProduct: product)
            }
            
            return cell
        case .buy:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProductDetailBuyCell.self), for: indexPath) as! ProductDetailBuyCell
            cell.didTapBuyButton = { [weak self] in
                guard let self = self else { return }
                self.coordinator?.buy(product: self.product)
            }
            
            return cell
        }
    }
    
}

class ProductDetailCell: UITableViewCell {}
class ProductDetailBuyCell: UITableViewCell {
    
    var didTapBuyButton: (() -> Void)?
    
    @IBAction func didTapBuyButton(_ sender: UIButton) {
        didTapBuyButton?()
    }
    
}
