//
//  CoinView.swift
//  BitHolder
//
//  Created by grigori on 09.05.2021.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

class CoinView: UIView {
    
    var viewModel: CoinCellViewModel!
    
    let icon = UIImageView()
    let name = UILabel()
    let capRank = UILabel()
    let ticker = UILabel()
    
    let price = UILabel()
    let percents = UILabel()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(icon)
        addSubview(name)
        addSubview(capRank)
        addSubview(ticker)
        addSubview(price)
        addSubview(percents)
        
        setupConstraints()
        setupViewsData()
    }
    
    func setupViewsData() {
        
        DispatchQueue.main.async {
            let url = URL(string: self.viewModel.iconUrl)
            self.icon.kf.setImage(with: url)
            self.name.attributedText = NSAttributedString(text: self.viewModel.name, style: AttributedStringStyle.companyDescription)
            self.capRank.attributedText = NSAttributedString(text: self.viewModel.capRank, style: AttributedStringStyle.purchasedStocksSubtitle)
            
            self.capRank.backgroundColor = .systemGray5
            self.capRank.layer.cornerRadius = 3
            self.capRank.layer.masksToBounds = true
            
            self.ticker.attributedText = NSAttributedString(text: self.viewModel.ticker, style: AttributedStringStyle.orderWaiting)
            
            self.price.attributedText = NSAttributedString(text: self.viewModel.price, style: AttributedStringStyle.companyDescription)
            
            let percentStyle = self.viewModel.percents.first == "-" ? AttributedStringStyle.stockCellPercentMinusCentered : AttributedStringStyle.stockCellPercentPlusCentered
            self.percents.attributedText = NSAttributedString(text: self.viewModel.percents, style: percentStyle)
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
            m.top.equalTo(12)
            m.left.equalTo(icon.snp.right).offset(10)
        }
        
        capRank.snp.makeConstraints { (m) in
            m.top.equalTo(name.snp.bottom).offset(5)
            m.height.equalTo(12)
            m.width.greaterThanOrEqualTo(12)
            m.left.equalTo(icon.snp.right).offset(10)
        }
        
        ticker.snp.makeConstraints { (m) in
            m.top.equalTo(name.snp.bottom).offset(4)
            m.left.equalTo(capRank.snp.right).offset(8)
        }
        
        price.snp.makeConstraints { (m) in
            m.top.equalTo(12)
            m.right.equalTo(-14)
        }
        
        percents.snp.makeConstraints { (m) in
            m.top.equalTo(price.snp.bottom).offset(4)
            m.right.equalTo(-14)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class CoinCellViewModel {
    
    let iconUrl: String
    let name: String
    let capRank: String
    let ticker: String
    
    var price: String
    var percents: String
    
    init(_ coinData: CoinData) {
        
        self.iconUrl = coinData.image ?? ""
        self.name = coinData.name ?? "-"
        self.capRank = coinData.market_cap_rank?.description ?? "-"
        self.ticker = coinData.symbol?.uppercased() ?? "-"
        self.price = coinData.current_price?.formattedWithSeparator ?? "-"
        if coinData.market_cap_rank == 1 {
            let rand = Int.random(in: 10...99)
            
            self.price.append(".\(rand)")
        }
        self.price.append(" $")
        
        
        let percent = coinData.price_change_percentage_24h?.description ?? "-"
        
        let delimiter = "."
        let token = percent.components(separatedBy: delimiter)
        let first = token[0]
        let last = token[1]
        
        var prc = first
        prc.append(".")
        prc.append(contentsOf: last.prefix(2))
        prc.append(" %")
        
        self.percents = prc
    }
}
