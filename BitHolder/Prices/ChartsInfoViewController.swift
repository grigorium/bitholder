//
//  ChartsInfoViewController.swift
//  BitHolder
//
//  Created by grigori on 05.06.2021.
//

import UIKit
import SnapKit
import Charts

class ChartsInfoViewController: UIViewController, ChartViewDelegate {
    
    var viewModel: ChartsInfoViewModel!
    
    let backButton = UIButton(type: .custom)
    let scrollView = UIScrollView()
    let activityIndicator = UIActivityIndicatorView(style: .large)
    let chartView = LineChartView()
    var markerView: ChartMarkerView!

    var leftChartConstraint: Constraint!
    
    let lowPriceLabel = UILabel()
    let highPriceLabel = UILabel()
    let lowDateLabel = UILabel()
    let highDateLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white

        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (m) in
            m.edges.equalToSuperview()
        }
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        scrollView.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { (m) in
            m.center.equalToSuperview()
        }
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        setupBackButton()

        setupChart()
    }
    
    func setupChart() {
        
        viewModel.fetchData { [weak self] (chartDataValue) in
            guard let self = self else { return }
            
            var lineChartEntry = [ChartDataEntry]()
            let val = chartDataValue.prices
            var arr = [Double]()
            
            for i in 0..<val.count {
                let value = ChartDataEntry(x: val[i][0], y: val[i][1])
                lineChartEntry.append(value)
                
                arr.append(val[i][1])
            }
            
            let set = LineChartDataSet(entries: lineChartEntry, label: nil)
            set.colors = [NSUIColor.systemGreen]
            set.drawCirclesEnabled = false
            set.mode = .cubicBezier
            set.lineWidth = 3
            set.fill = Fill(color: .systemGreen)
            set.fillAlpha = 0.6
            set.drawFilledEnabled = true
            set.drawValuesEnabled = false
            
            
            let chartData = LineChartData()
            chartData.addDataSet(set)
            self.chartView.data = chartData
            
            self.chartView.setScaleEnabled(false)
            self.chartView.minOffset = 0
            self.chartView.legend.form = .none
            self.chartView.rightAxis.enabled = false
            self.chartView.leftAxis.enabled = false
            self.chartView.drawGridBackgroundEnabled = false
            self.chartView.xAxis.enabled = false
            self.chartView.delegate = self
            
            DispatchQueue.main.async { [self] in
                self.activityIndicator.stopAnimating()
                
                self.scrollView.addSubview(self.chartView)
                self.chartView.backgroundColor = UIColor.white
                self.chartView.snp.makeConstraints { (m) in
                    m.top.equalTo(115)
                    m.centerX.equalToSuperview()
                    m.height.equalTo(self.view.snp.width).multipliedBy(0.95)
                    m.left.equalTo(8)
                    m.right.equalTo(-8)
                }
                
                self.markerView = ChartMarkerView(chartStyle: .briefcase)
                self.scrollView.addSubview(self.markerView)
                self.scrollView.bringSubviewToFront(self.markerView)
                self.markerView.snp.makeConstraints { (m) in
                    self.leftChartConstraint = m.left.equalTo(self.chartView.snp.left).constraint
                    m.right.lessThanOrEqualToSuperview()
                    m.top.equalTo(self.chartView.snp.top)
                }
                self.markerView.layer.opacity = 0
                
                guard !lineChartEntry.isEmpty else { return }
                
                self.lowDateLabel.attributedText = NSAttributedString(text: self.makeDate(entry: lineChartEntry.first!), style: .filterText)
                self.scrollView.addSubview(self.lowDateLabel)
                self.lowDateLabel.snp.makeConstraints { (m) in
                    m.top.equalTo(self.chartView.snp.bottom)
                    m.left.equalTo(self.chartView.snp.left)
                }
                
                self.highDateLabel.attributedText = NSAttributedString(text: self.makeDate(entry: lineChartEntry.last!), style: .filterText)
                self.scrollView.addSubview(self.highDateLabel)
                self.highDateLabel.snp.makeConstraints { (m) in
                    m.top.equalTo(self.chartView.snp.bottom)
                    m.right.equalTo(self.chartView.snp.right)
                }
                
                self.highPriceLabel.attributedText = NSAttributedString(text: self.makeDolla(entry: arr.max()!), style: .filterText)
                self.chartView.addSubview(self.highPriceLabel)
                self.highPriceLabel.snp.makeConstraints { (m) in
                    m.top.equalTo(self.chartView.snp.top)
                    m.right.equalTo(self.chartView.snp.right).offset(-5)
                }
                
                self.lowPriceLabel.attributedText = NSAttributedString(text: self.makeDolla(entry: arr.min()!), style: .filterText)
                self.scrollView.addSubview(self.lowPriceLabel)
                self.lowPriceLabel.snp.makeConstraints { (m) in
                    m.bottom.equalTo(self.chartView.snp.bottom).offset(-25)
                    m.right.equalTo(self.chartView.snp.right).offset(-5)
                }
                
                let numA = lineChartEntry.first?.y ?? 0
                let numB = lineChartEntry.last?.y ?? 0
                
                let percentChange = ((numB - numA)/numA)*100
                
                self.topSideLabels(ticker: self.viewModel.ticker, percentChange: percentChange)
                
                self.bottomLabels(coinData: self.viewModel.coinData)
            }
        }
    }
    
    func bottomLabels(coinData: CoinData) {
        DispatchQueue.main.async {
            
            let containerForDetails = UIView()
            self.scrollView.addSubview(containerForDetails)
            containerForDetails.snp.makeConstraints { (m) in
                m.top.equalTo(self.chartView.snp.bottom).offset(20)
                m.left.width.equalToSuperview()
                m.height.equalTo(300)
                m.bottom.equalToSuperview()
            }
            
            let priceLabel = UILabel()
            let maxLabel = UILabel()
            let maxValLabel = UILabel()
            let minLabel = UILabel()
            let minValLabel = UILabel()
            let priceChLabel = UILabel()
            let priceChValLabel = UILabel()
            
            let capLabel = UILabel()
            let capValLabel = UILabel()
            let capChLabel = UILabel()
            let capChValLabel = UILabel()
            
            let tokensLabel = UILabel()
            let tokensValLabel = UILabel()
            let tokensAllLabel = UILabel()
            let tokensAllValLabel = UILabel()
            
            let arr = [priceLabel,
                       maxLabel, maxValLabel, minLabel, minValLabel, priceChLabel, priceChValLabel,
                       capLabel, capValLabel, capChLabel, capChValLabel,
                       tokensLabel, tokensValLabel, tokensAllLabel, tokensAllValLabel]
            arr.forEach { containerForDetails.addSubview($0) }
            
            priceLabel.attributedText = NSAttributedString(text: "\(coinData.id?.uppercased() ?? ""): \(coinData.current_price?.formattedWithSeparator.appending(" $") ?? "")", style: .indentificationResultSubtitle)
            priceLabel.snp.makeConstraints { (m) in
                m.top.equalTo(containerForDetails).offset(25)
                m.left.equalTo(8)
            }
            
            maxLabel.attributedText = NSAttributedString(text: "Максимум (24ч):", style: .indentificationResultSubtitle2)
            maxLabel.snp.makeConstraints { (m) in
                m.top.equalTo(priceLabel.snp.bottom).offset(15)
                m.left.equalTo(8)
            }
            maxValLabel.attributedText = NSAttributedString(text: coinData.high_24h?.formattedWithSeparator.appending(" $") ?? "", style: .indentificationResultSubtitle)
            maxValLabel.snp.makeConstraints { (m) in
                m.top.equalTo(priceLabel.snp.bottom).offset(15)
                m.right.equalTo(-8)
            }
            
            minLabel.attributedText = NSAttributedString(text: "Минимум (24ч):", style: .indentificationResultSubtitle2)
            minLabel.snp.makeConstraints { (m) in
                m.top.equalTo(maxLabel.snp.bottom).offset(5)
                m.left.equalTo(8)
            }
            minValLabel.attributedText = NSAttributedString(text: coinData.low_24h?.formattedWithSeparator.appending(" $") ?? "", style: .indentificationResultSubtitle)
            minValLabel.snp.makeConstraints { (m) in
                m.top.equalTo(maxLabel.snp.bottom).offset(5)
                m.right.equalTo(-8)
            }
            
            priceChLabel.attributedText = NSAttributedString(text: "Изменение (24ч):", style: .indentificationResultSubtitle2)
            priceChLabel.snp.makeConstraints { (m) in
                m.top.equalTo(minValLabel.snp.bottom).offset(5)
                m.left.equalTo(8)
            }
            let pcn = String(format: "%.2f", (coinData.price_change_percentage_24h?.doubleValue ?? 0))
            var pcvlt = coinData.price_change_24h?.formattedWithSeparator.appending(" $") ?? ""
            pcvlt.append("  (\(pcn) %)")
            priceChValLabel.attributedText = NSAttributedString(text: pcvlt, style: .indentificationResultSubtitle)
            priceChValLabel.snp.makeConstraints { (m) in
                m.top.equalTo(minValLabel.snp.bottom).offset(5)
                m.right.equalTo(-8)
            }
            
            capLabel.attributedText = NSAttributedString(text: "Капитализация:", style: .indentificationResultSubtitle2)
            capLabel.snp.makeConstraints { (m) in
                m.top.equalTo(priceChValLabel.snp.bottom).offset(15)
                m.left.equalTo(8)
            }
            capValLabel.attributedText = NSAttributedString(text: coinData.market_cap?.formattedWithSeparator.appending(" $") ?? "", style: .indentificationResultSubtitle)
            capValLabel.snp.makeConstraints { (m) in
                m.top.equalTo(priceChValLabel.snp.bottom).offset(15)
                m.right.equalTo(-8)
            }
            
            capChLabel.attributedText = NSAttributedString(text: "Изменение (24ч):", style: .indentificationResultSubtitle2)
            capChLabel.snp.makeConstraints { (m) in
                m.top.equalTo(capValLabel.snp.bottom).offset(5)
                m.left.equalTo(8)
            }
            let pcn2 = String(format: "%.2f", (coinData.market_cap_change_percentage_24h?.doubleValue ?? 0))
            var pcvlt2 = coinData.market_cap_change_24h?.formattedWithSeparator.appending(" $") ?? ""
            pcvlt2.append("  (\(pcn2) %)")
            capChValLabel.attributedText = NSAttributedString(text: pcvlt2, style: .indentificationResultSubtitle)
            capChValLabel.snp.makeConstraints { (m) in
                m.top.equalTo(capValLabel.snp.bottom).offset(5)
                m.right.equalTo(-8)
            }
            
            
            tokensLabel.attributedText = NSAttributedString(text: "Токенов в обороте на рынке:", style: .indentificationResultSubtitle2)
            tokensLabel.snp.makeConstraints { (m) in
                m.top.equalTo(capChLabel.snp.bottom).offset(15)
                m.left.equalTo(8)
            }
            tokensValLabel.attributedText = NSAttributedString(text: coinData.circulating_supply?.formattedWithSeparator ?? "", style: .indentificationResultSubtitle)
            tokensValLabel.snp.makeConstraints { (m) in
                m.top.equalTo(capChLabel.snp.bottom).offset(15)
                m.right.equalTo(-8)
            }
            
            tokensAllLabel.attributedText = NSAttributedString(text: "Всего выпущено токенов:", style: .indentificationResultSubtitle2)
            tokensAllLabel.snp.makeConstraints { (m) in
                m.top.equalTo(tokensLabel.snp.bottom).offset(5)
                m.left.equalTo(8)
            }
            tokensAllValLabel.attributedText = NSAttributedString(text: coinData.total_supply?.formattedWithSeparator ?? "", style: .indentificationResultSubtitle)
            tokensAllValLabel.snp.makeConstraints { (m) in
                m.top.equalTo(tokensLabel.snp.bottom).offset(5)
                m.right.equalTo(-8)
            }
            
        }
    }
    
    func topSideLabels(ticker: String, percentChange: Double) {
        DispatchQueue.main.async {
            let descLabel = UILabel()
            descLabel.attributedText = NSAttributedString(text: "\(ticker) - USD", style: .purchasedStocks)
            self.scrollView.addSubview(descLabel)
            descLabel.snp.makeConstraints { (m) in
                m.top.equalTo(80)
                m.left.equalTo(15)
            }
            
            let percentLabel = UILabel()
            
            var percentText = String(format: "%.2f", percentChange)
            if percentChange > 0 {
                percentText = "+" + percentText
            }
            let percentStyle = (percentChange < 0) ? AttributedStringStyle.stockCellPercentMinus : AttributedStringStyle.stockCellPercentPlus
            
            percentLabel.attributedText = NSAttributedString(text: percentText + " %", style: percentStyle)
            self.scrollView.addSubview(percentLabel)
            percentLabel.snp.makeConstraints { (m) in
                m.top.equalTo(85)
                m.right.equalTo(self.chartView.snp.right).offset(-5)
            }
        }
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {

        markerView.dateLabel.text = makeDate(entry: entry)
        markerView.valueLabel.text = makeDolla(entry: entry.y)
        
        let xPosition = highlight.xPx
        let yPosition = highlight.yPx
        let screenWidth = UIScreen.main.bounds.width
        
        var markerLeftOffset: CGFloat!
        var lineLeftOffset: CGFloat!
        if xPosition <= markerView.width/2 {
            markerLeftOffset = 0
            lineLeftOffset = xPosition
        } else if screenWidth - xPosition <= markerView.width/2 {
            markerLeftOffset = screenWidth - markerView.width
            lineLeftOffset = markerView.width/2 + abs(screenWidth - markerView.width/2 - xPosition)
        } else {
            markerLeftOffset = xPosition - markerView.width/2
            lineLeftOffset = markerView.width/2
        }
        markerView.updateHeightAndLeftConstraints(height: yPosition - markerView.height, left: lineLeftOffset)
        markerView.snp.updateConstraints { (m) in
            leftChartConstraint.update(offset: markerLeftOffset)
        }
        markerView.layer.opacity = 1
        markerView.layoutIfNeeded()
    }

    func setupBackButton() {
        view.addSubview(backButton)
        backButton.snp.makeConstraints { (m) in
            m.size.width.equalTo(30)
            m.left.equalTo(5)
            m.top.equalTo(38)
        }
        backButton.setBackgroundImage(UIImage(named: "arrowiosback"), for: .normal)
        backButton.addTarget(self, action: #selector(dismissVc), for: .touchUpInside)
    }
    
    @objc func dismissVc() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func makeDate(entry: ChartDataEntry) -> String {
        let index = entry.x/1000
        let date = Date(timeIntervalSince1970: index)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "dd MMMM"
        return dateFormatter.string(from: date)
    }
    
    func makeDolla(entry: Double) -> String {
        let summ = entry.description
        
        let delimiter = "."
        let token = summ.components(separatedBy: delimiter)
        let first = token[0]
        let last = token[1]
        
        var prc = first
        prc.append(".")
        prc.append(contentsOf: last.prefix(2))
        prc.append(" $")
        
        return prc
    }
}
