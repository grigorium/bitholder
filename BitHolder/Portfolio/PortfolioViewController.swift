//
//  PortfolioViewController.swift
//  BitHolder
//
//  Created by grigori on 02.05.2021.
//

import Foundation
import UIKit
import SnapKit

class PortfolioViewController: UIViewController, PricesViewModelDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    var viewModel: PricesViewModel?
    
    var cellModels: [CoinData]?
    
    let tableView = UITableView()
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    let button = UIButton(type: .custom)
    
    let titleLabel = UILabel()
    
    let addCoinButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        viewModel = PricesViewModel()
        viewModel?.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(titleLabel)
        titleLabel.attributedText = NSMutableAttributedString(text: "Активы", style: .boldHeader)
        titleLabel.snp.makeConstraints { (m) in
            m.top.equalTo(60)
            m.left.equalTo(20)
            m.height.equalTo(40)
        }
        
        addCoinButton.backgroundColor = UIColor.systemBlue
        addCoinButton.layer.cornerRadius = 20
        addCoinButton.setTitle("Добавить криптовалюту", for: .normal)
        view.addSubview(addCoinButton)
        addCoinButton.snp.makeConstraints { (m) in
            m.top.equalTo(titleLabel.snp.bottom).offset(10)
            m.left.equalTo(20)
            m.height.equalTo(40)
            m.centerX.equalToSuperview()
        }
        

        addCoinButton.addTarget(self, action: #selector(openCoinList), for: .touchUpInside)
        
//        view.addSubview(tableView)
//        tableView.snp.makeConstraints { (m) in
//            m.top.equalTo(addCoinButton.snp.bottom).offset(30)
//            m.left.right.bottom.equalToSuperview()
//        }
        tableView.backgroundColor = .white
        tableView.allowsSelection = false
        
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
    
    @objc func openCoinList() {
        let vc = PortfolioCoinList()
        vc.cellModels = self.cellModels ?? []
        self.navigationController?.pushViewController(vc, animated: true)
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
    
}
