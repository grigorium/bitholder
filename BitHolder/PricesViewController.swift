//
//  PricesViewController.swift
//  BitHolder
//
//  Created by grigori on 02.05.2021.
//

import Foundation
import UIKit
import SnapKit

class PricesViewController: UIViewController, PricesViewModelDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    var viewModel: PricesViewModel?
    
    var cellModels: [CoinData]?
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        viewModel = PricesViewModel()
        viewModel?.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (m) in
            m.top.equalTo(80)
            m.left.right.bottom.equalToSuperview()
        }
        tableView.backgroundColor = .white
        tableView.allowsSelection = false
    }
    
    func update() {
        if let pricesList = viewModel?.prices {
            
            cellModels = pricesList
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellModels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CoinCell()
        guard let cm = cellModels?[indexPath.row] else {
            return cell
        }
        cell.viewModel = CoinCellViewModel(cm)
        return cell
    }
    
}
