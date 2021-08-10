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
    
    let scrollView = UIScrollView()
    
    let balanceLabel: UILabel = {
        let label = UILabel()
        var str = NSMutableAttributedString(text: "СТОИМОСТЬ ПОРТФЕЛЯ", style: .briefCasePrice)
        str.addAttribute(kCTKernAttributeName as NSAttributedString.Key, value: 0.5, range: NSMakeRange(0, str.length))
        label.attributedText = str
        return label
    }()
    
    let balanceAmountLabel = UILabel()
    
    let marketLabel = UILabel()
    let marketView = UIView()
    
    let transactionsAndMiningLabel = UILabel()
    let transactionsAndMiningView = UIView()
    

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
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (m) in
            m.edges.equalToSuperview()
        }
        
        scrollView.addSubview(balanceLabel)
        balanceLabel.snp.makeConstraints { (m) in
            m.top.equalTo(100)
            m.centerX.equalToSuperview()
        }
        
        scrollView.addSubview(balanceAmountLabel)
        balanceAmountLabel.snp.makeConstraints { (m) in
            m.top.equalTo(balanceLabel.snp.bottom).offset(20)
            m.centerX.equalToSuperview()
        }
        scrollView.showsVerticalScrollIndicator = false
        
        viewModel = MainViewModel()
        viewModel?.delegate = self
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        viewModel?.start()
//    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//
//        for view in marketView.subviews {
//            view.removeFromSuperview()
//        }
//        for view in transactionsAndMiningView.subviews {
//            view.removeFromSuperview()
//        }
//    }
    
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
        } else {
            //error view
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
    
    private func setupInfoViews(stats: BtcStatsData) {
        DispatchQueue.main.async {
            
            self.scrollView.addSubview(self.marketLabel)
            self.marketLabel.snp.makeConstraints { (m) in
                m.top.equalTo(self.balanceAmountLabel.snp.bottom).offset(110)
                m.left.equalTo(15)
            }
            self.marketLabel.attributedText = NSAttributedString(text: "ОБЗОР РЫНКА BTC", style: AttributedStringStyle.investIdea)
            
            self.scrollView.addSubview(self.marketView)
            self.marketView.backgroundColor = UIColor(white: 1, alpha: 0.25)
            self.marketView.layer.cornerRadius = 15
            self.marketView.snp.makeConstraints { (m) in
                m.centerX.equalToSuperview()
                m.left.equalTo(10)
                m.top.equalTo(self.marketLabel.snp.bottom).offset(5)
                m.height.equalTo(130)
            }
            
            self.scrollView.addSubview(self.transactionsAndMiningLabel)
            self.transactionsAndMiningLabel.snp.makeConstraints { (m) in
                m.top.equalTo(self.marketView.snp.bottom).offset(20)
                m.left.equalTo(15)
            }
            self.transactionsAndMiningLabel.attributedText = NSAttributedString(text: "ТРАНЗАКЦИИ И МАЙНИНГ BTC", style: AttributedStringStyle.investIdea)

            
            self.scrollView.addSubview(self.transactionsAndMiningView)
            self.transactionsAndMiningView.backgroundColor = .white
            self.transactionsAndMiningView.backgroundColor = UIColor(white: 1, alpha: 0.25)
            
            self.transactionsAndMiningView.layer.cornerRadius = 15
            self.transactionsAndMiningView.snp.makeConstraints { (m) in
                m.centerX.equalToSuperview()
                m.left.equalTo(10)
                m.top.equalTo(self.transactionsAndMiningLabel.snp.bottom).offset(5)
                m.height.equalTo(230)
                m.bottom.equalToSuperview().offset(-10)
            }
            
            self.addMarketLabels(stats: stats)
            self.addMiningLabels(stats: stats)
        }
    }
    
    func addMarketLabels(stats: BtcStatsData) {
        let price = UILabel()
        price.attributedText = NSAttributedString(text: "Рыночная цена сегодня", style: AttributedStringStyle.newsCellArticle)
        let volumeUsd = UILabel()
        volumeUsd.attributedText = NSAttributedString(text: "Капитализация", style: AttributedStringStyle.newsCellArticle)
        let volumeBtc = UILabel()
        volumeBtc.attributedText = NSAttributedString(text: "Доминантность рынка", style: AttributedStringStyle.newsCellArticle)
        let totalbc = UILabel()
        totalbc.attributedText = NSAttributedString(text: "Всего биткоинов в обороте", style: AttributedStringStyle.newsCellArticle)
        
        let priceVal = UILabel()
        priceVal.attributedText = NSAttributedString(text: Int(stats.market_price_usd).formattedWithSeparator + " $", style: AttributedStringStyle.investIdeaDate)
        let volumeUsdVal = UILabel()
        volumeUsdVal.attributedText = NSAttributedString(text:
                                                            Int(stats.market_cap_usd).formattedWithSeparator + " $", style: AttributedStringStyle.investIdeaDate)
        let volumeBtcVal = UILabel()
        volumeBtcVal.attributedText = NSAttributedString(text: stats.market_dominance_percentage.description + " %", style: AttributedStringStyle.investIdeaDate)
        let totalbcVal = UILabel()
        let totalBcv = (Int(stats.circulation/100000000)).formattedWithSeparator
        totalbcVal.attributedText = NSAttributedString(text: totalBcv + " ₿", style: AttributedStringStyle.investIdeaDate)
        
        let arr = [price, volumeUsd, volumeBtc, totalbc]
        let arrVal = [priceVal, volumeUsdVal, volumeBtcVal, totalbcVal]
        
        for i in 0..<arr.count {
            marketView.addSubview(arr[i])
            arr[i].snp.makeConstraints { (m) in
                i == 0 ? m.top.equalTo(10) : m.top.equalTo(arr[i-1].snp.bottom).offset(10)
                m.left.equalTo(15)
            }
        }
        
        for i in 0..<arrVal.count {
            marketView.addSubview(arrVal[i])
            arrVal[i].snp.makeConstraints { (m) in
                i == 0 ? m.top.equalTo(10) : m.top.equalTo(arr[i-1].snp.bottom).offset(10)
                m.right.equalTo(-15)
            }
        }
    }
    
    func addMiningLabels(stats: BtcStatsData) {
        let ts11 = UILabel()
        ts11.attributedText = NSAttributedString(text: "Хешрейт", style: AttributedStringStyle.newsCellArticle)
        let ts1b = UILabel()
        ts1b.attributedText = NSAttributedString(text: "Блоков всего", style: AttributedStringStyle.newsCellArticle)
        let ts12 = UILabel()
        ts12.attributedText = NSAttributedString(text: "Блоков (24ч)", style: AttributedStringStyle.newsCellArticle)
        let ts13 = UILabel()
        ts13.attributedText = NSAttributedString(text: "Транзакций (24ч)", style: AttributedStringStyle.newsCellArticle)
        let ts14 = UILabel()
        ts14.attributedText = NSAttributedString(text: "Размер блокчейна", style: AttributedStringStyle.newsCellArticle)
        let ts15 = UILabel()
        ts15.attributedText = NSAttributedString(text: "Средняя комиссия транзакции", style: AttributedStringStyle.newsCellArticle)
        let ts16 = UILabel()
        ts16.attributedText = NSAttributedString(text: "Медианная комиссия транзакции", style: AttributedStringStyle.newsCellArticle)
        let ts17 = UILabel()
        ts17.attributedText = NSAttributedString(text: "Инфляция (24ч)", style: AttributedStringStyle.newsCellArticle)
        
        let arrts1 = [ts11, ts1b, ts12, ts13, ts14, ts15, ts16, ts17]
        
        for i in 0..<arrts1.count {
            self.transactionsAndMiningView.addSubview(arrts1[i])
            arrts1[i].snp.makeConstraints { (m) in
                i == 0 ? m.top.equalTo(10) : m.top.equalTo(arrts1[i-1].snp.bottom).offset(10)
                m.left.equalTo(15)
            }
        }
        
        let ts21 = UILabel()
        ts21.attributedText = NSAttributedString(text: stats.hashrate_24h.description + " H/s", style: AttributedStringStyle.investIdeaDate)
        let ts2b = UILabel()
        ts2b.attributedText = NSAttributedString(text: stats.blocks.formattedWithSeparator, style: AttributedStringStyle.investIdeaDate)
        let ts22 = UILabel()
        ts22.attributedText = NSAttributedString(text: Int(stats.blocks_24h).description, style: AttributedStringStyle.investIdeaDate)
        let ts23 = UILabel()
        ts23.attributedText = NSAttributedString(text: stats.transactions_24h.formattedWithSeparator, style: AttributedStringStyle.investIdeaDate)
        let ts24 = UILabel()
        ts24.attributedText = NSAttributedString(text: stats.blockchain_size.formattedWithSeparator, style: AttributedStringStyle.investIdeaDate)
        let ts25 = UILabel()
        ts25.attributedText = NSAttributedString(text: stats.average_transaction_fee_usd_24h.formattedWithSeparator + " $", style: AttributedStringStyle.investIdeaDate)
        let ts26 = UILabel()
        ts26.attributedText = NSAttributedString(text: stats.median_transaction_fee_usd_24h.formattedWithSeparator + " $", style: AttributedStringStyle.investIdeaDate)
        let ts27 = UILabel()
        ts27.attributedText = NSAttributedString(text: stats.inflation_usd_24h.formattedWithSeparator + " $", style: AttributedStringStyle.investIdeaDate)
        
        let arrts2 = [ts21, ts2b, ts22, ts23, ts24, ts25, ts26, ts27]
        
        for i in 0..<arrts2.count {
            self.transactionsAndMiningView.addSubview(arrts2[i])
            arrts2[i].snp.makeConstraints { (m) in
                i == 0 ? m.top.equalTo(10) : m.top.equalTo(arrts2[i-1].snp.bottom).offset(10)
                m.right.equalTo(-15)
            }
        }
    }
}
