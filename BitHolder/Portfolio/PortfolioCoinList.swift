//
//  PortfolioCoinList.swift
//  BitHolder
//
//  Created by grigori on 05.06.2021.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

class PortfolioCoinList: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let button = UIButton(type: .custom)
    
    var cellModels: [CoinData]?
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        //viewModel = PricesViewModel()
        //viewModel?.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (m) in
            m.top.equalTo(100)
            m.left.right.bottom.equalToSuperview()
        }
        tableView.backgroundColor = .white
        //tableView.allowsSelection = false
        
        view.addSubview(button)
        button.snp.makeConstraints { (m) in
            m.size.width.equalTo(30)
            m.left.equalTo(15)
            m.top.equalTo(48)
        }
        button.setBackgroundImage(UIImage(named: "arrowiosback"), for: .normal)
        button.addTarget(self, action: #selector(dismissVc), for: .touchUpInside)
    }
    
    @objc func dismissVc() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellModels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SimpleCoinCell()
        guard let cm = cellModels?[indexPath.row] else {
            return cell
        }
        cell.viewModel = SimpleCoinCellViewModel(cm)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cd = cellModels?[indexPath.row] else {
            return
        }
        
        let vm = PortfolioCoinAdditionViewModel()//ChartsInfoViewModel(coinData: cd)
        let vc = PortfolioCoinAdditionViewController()
        vc.viewModel = vm
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


class SimpleCoinCell: UITableViewCell {
    
    let coinView = PortfolioCoinView()
    
    var viewModel: SimpleCoinCellViewModel! {
        didSet {
            coinView.viewModel = viewModel
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(coinView)
        coinView.snp.makeConstraints { (m) in
            m.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //catalogView.reset()
    }
    
}

class PortfolioCoinView: UIView {
    
    var viewModel: SimpleCoinCellViewModel!
    
    let icon = UIImageView()
    let name = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(icon)
        addSubview(name)
        
        setupConstraints()
        setupViewsData()
    }
    
    func setupViewsData() {
        
        DispatchQueue.main.async {
            let url = URL(string: self.viewModel.iconUrl)
            self.icon.kf.setImage(with: url)
            self.name.attributedText = NSAttributedString(text: self.viewModel.name, style: AttributedStringStyle.companyDescription)
        }
    }

    
    func setupConstraints() {
        
        icon.snp.makeConstraints { (m) in
            m.top.equalTo(10)
            m.left.equalTo(14)
            m.size.equalTo(32)
            m.bottom.equalTo(-10)
        }
        
        name.snp.makeConstraints { (m) in
            m.centerY.equalToSuperview()
            m.left.equalTo(icon.snp.right).offset(20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class SimpleCoinCellViewModel {
    
    let iconUrl: String
    let name: String
    
    init(_ coinData: CoinData) {
        
        self.iconUrl = coinData.image ?? ""
        self.name = coinData.name ?? "-"
    }
}
