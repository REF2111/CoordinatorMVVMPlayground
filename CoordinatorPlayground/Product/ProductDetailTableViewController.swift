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
    
    private var viewModel: ProductViewModel!
    
    init(viewModel: ProductViewModel) {
        self.viewModel = viewModel
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
    var viewModel: ProductViewModel!
        
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = viewModel.name
        
        self.dataSource = ProductDetailTableViewDataSource(viewModel: viewModel)
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
                cell.textLabel?.text = viewModel.name
            case .price:
                cell.textLabel?.text = viewModel.priceString
            case .availableSince:
                cell.textLabel?.text = viewModel.dateString
            }
            
            return cell
        case .buy:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProductDetailBuyCell.self), for: indexPath) as! ProductDetailBuyCell
            cell.didTapBuyButton = { [weak self] in
                self?.viewModel.buy()
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
