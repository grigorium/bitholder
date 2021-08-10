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
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    let button = UIButton(type: .custom)
    
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
        
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { (m) in
            m.center.equalToSuperview()
        }
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        tableView.isHidden = true
        
        view.addSubview(button)
        button.snp.makeConstraints { (m) in
            m.size.width.equalTo(18)
            m.right.equalTo(-20)
            m.top.equalTo(48)
        }
        button.setBackgroundImage(UIImage(named: "refresh"), for: .normal)
        button.addTarget(self, action: #selector(PricesViewController.reloadData), for: .touchUpInside)
    }
    
    func update() {
        if let pricesList = viewModel?.prices {
            
            cellModels = pricesList
            
            DispatchQueue.main.async {
                self.tableView.isHidden = false
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func reloadData() {
        self.viewModel?.start()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cm = cellModels?[indexPath.row] else {
            return
        }
        
        //coinViewcontroller
        let vm = ChartsInfoViewModel(coinId: cm.id ?? "bitcoin")
        let vc = ChartsInfoViewController()
        vc.viewModel = vm
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
