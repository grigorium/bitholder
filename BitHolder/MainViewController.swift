//
//  ViewController.swift
//  BitHolder
//
//  Created by grigori on 30.04.2021.
//

import UIKit
import SnapKit

class MainViewController: UIViewController, MainViewModelDelegate {
    
    var viewModel: MainViewModel?
    
    let mountainsImageView: UIImageView = {
        let i = UIImageView(image: UIImage(named: "mountainMiat"))
        i.contentMode = .scaleAspectFill
        return i
    }()
    
    let balanceLabel: UILabel = {
        let label = UILabel()
        var str = NSMutableAttributedString(text: "СТОИМОСТЬ ПОРТФЕЛЯ", style: .briefCasePrice)
        str.addAttribute(kCTKernAttributeName as NSAttributedString.Key, value: 0.5, range: NSMakeRange(0, str.length))
        label.attributedText = str
        return label
    }()
    
    let balanceAmountLabel = UILabel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(mountainsImageView)
        mountainsImageView.snp.makeConstraints { (m) in
            m.center.equalToSuperview()
            m.height.equalToSuperview().multipliedBy(1.6)
            m.width.equalToSuperview().multipliedBy(1.4)
        }
        mountainsImageView.setupMotionEffect()
        
        view.addSubview(balanceLabel)
        balanceLabel.snp.makeConstraints { (m) in
            m.top.equalTo(110)
            m.centerX.equalToSuperview()
        }
        
        view.addSubview(balanceAmountLabel)
        balanceAmountLabel.snp.makeConstraints { (m) in
            m.top.equalTo(balanceLabel.snp.bottom).offset(20)
            m.centerX.equalToSuperview()
        }
        
        viewModel = MainViewModel()
        viewModel?.delegate = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func getBalance() {
        let b = viewModel?.getBalance()
        balanceAmountLabel.attributedText = styleForTitle(money: b ?? "0.00")
        view.layoutIfNeeded()
    }
    
    func update() {
        if let sts = viewModel?.getStats() {
            setupInfoViews(stats: sts)
        }
    }

    private func styleForTitle(money: String) -> NSAttributedString {
        
        let delimiter = "."
        let token = money.components(separatedBy: delimiter)
        let first = token[0]
        let last = token[1]
        print("\(first) \(last)")

        let attrStr = NSMutableAttributedString(text: "\(first)", style: .heavyMoney)
        attrStr.addAttribute(kCTKernAttributeName as NSAttributedString.Key, value: 1, range: NSMakeRange(0, attrStr.length))
        attrStr.append(NSAttributedString(text: ",\(last)", style: .lightMoney))
        
        let currency = NSMutableAttributedString(text: " $", style: .heavyMoney)
        
        attrStr.append(currency)
        
        return attrStr
    }
    
    private func setupInfoViews(stats: Stats) {
        DispatchQueue.main.async {
            let marketLabel = UILabel()
            self.view.addSubview(marketLabel)
            marketLabel.snp.makeConstraints { (m) in
                m.top.equalTo(self.balanceAmountLabel.snp.bottom).offset(150)
                m.left.equalTo(15)
            }
            marketLabel.attributedText = NSAttributedString(text: "ОБЗОР РЫНКА", style: AttributedStringStyle.investIdea)
            
            let marketView = UIView()
            self.view.addSubview(marketView)
            marketView.backgroundColor = UIColor(white: 1, alpha: 0.25)
            //marketView.alpha = 0.25
            marketView.layer.cornerRadius = 15
            marketView.snp.makeConstraints { (m) in
                m.centerX.equalToSuperview()
                m.left.equalTo(10)
                m.top.equalTo(marketLabel.snp.bottom).offset(5)
                m.height.equalTo(130)
            }
            
            let price = UILabel()
            price.attributedText = NSAttributedString(text: "Рыночная цена", style: AttributedStringStyle.newsCellArticle)
            let volumeUsd = UILabel()
            volumeUsd.attributedText = NSAttributedString(text: "Объем сделок", style: AttributedStringStyle.newsCellArticle)
            let volumeBtc = UILabel()
            volumeBtc.attributedText = NSAttributedString(text: "Объем сделок", style: AttributedStringStyle.newsCellArticle)
            let totalbc = UILabel()
            totalbc.attributedText = NSAttributedString(text: "Всего биткоинов", style: AttributedStringStyle.newsCellArticle)
            
            let priceVal = UILabel()
            priceVal.attributedText = NSAttributedString(text: stats.market_price_usd.description + " $", style: AttributedStringStyle.investIdeaDate)
            let volumeUsdVal = UILabel()
            volumeUsdVal.attributedText = NSAttributedString(text:
                stats.trade_volume_usd.description + " $", style: AttributedStringStyle.investIdeaDate)
            let volumeBtcVal = UILabel()
            volumeBtcVal.attributedText = NSAttributedString(text: stats.trade_volume_btc.description + " ₿", style: AttributedStringStyle.investIdeaDate)
            let totalbcVal = UILabel()
            let totalBcv = stats.totalbc.description
            let index = totalBcv.index(totalBcv.startIndex, offsetBy: 8)
            let mySubstring = totalBcv.prefix(upTo: index)
            totalbcVal.attributedText = NSAttributedString(text: String(mySubstring), style: AttributedStringStyle.investIdeaDate)
            
            let arr = [price, volumeUsd, volumeBtc, totalbc]
            let arrVal = [priceVal, volumeUsdVal, volumeBtcVal, totalbcVal]
            
            for i in 0..<arr.count {
                marketView.addSubview(arr[i])
                arr[i].snp.makeConstraints { (m) in
                    i == 0 ? m.top.equalTo(10) : m.top.equalTo(arr[i-1].snp.bottom).offset(10)
                    m.left.equalTo(15)
                    //m.width.lessThanOrEqualTo(70)
                }
            }
            
            for i in 0..<arrVal.count {
                marketView.addSubview(arrVal[i])
                arrVal[i].snp.makeConstraints { (m) in
                    i == 0 ? m.top.equalTo(10) : m.top.equalTo(arr[i-1].snp.bottom).offset(10)
                    m.right.equalTo(-15)
                }
            }
            
            
            
            
            let transactionSummaryLabel = UILabel()
            self.view.addSubview(transactionSummaryLabel)
            transactionSummaryLabel.snp.makeConstraints { (m) in
                m.top.equalTo(marketView.snp.bottom).offset(20)
                m.left.equalTo(15)
            }
            transactionSummaryLabel.attributedText = NSAttributedString(text: "ТРАНЗАКЦИИ И МАЙНИНГ", style: AttributedStringStyle.investIdea)

            let transactionSummaryView = UIView()
            self.view.addSubview(transactionSummaryView)
            transactionSummaryView.backgroundColor = .white
            transactionSummaryView.backgroundColor = UIColor(white: 1, alpha: 0.25)
            
            //transactionSummaryView.alpha = 0.25
            transactionSummaryView.layer.cornerRadius = 15
            transactionSummaryView.snp.makeConstraints { (m) in
                m.centerX.equalToSuperview()
                m.left.equalTo(10)
                m.top.equalTo(transactionSummaryLabel.snp.bottom).offset(5)
                m.height.equalTo(220)
            }
        }
    }
}
