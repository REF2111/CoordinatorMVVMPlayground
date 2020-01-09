//
//  BuyViewController.swift
//  CoordinatorPlayground
//
//  Created by Raphael-Alexander Berendes on 03.01.20.
//  Copyright © 2020 Raphael-Alexander Berendes. All rights reserved.
//

import Combine
import UIKit

class BuyTableViewController: UITableViewController, Storyboarded {

    var viewModel: BuyViewModel!
    private var productCancellable: AnyCancellable?
    private var products = [ProductViewModel]()

    override func viewDidLoad() {

        super.viewDidLoad()

        title = "Buy"

        productCancellable = viewModel.productsValueSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] products in
                self?.products = products
                self?.tableView.reloadData()
        }
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
        Price: \(product.priceString)
        Available since: \(product.dateString)
        """

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.action.send(.detail(products[indexPath.row]))
    }
}
