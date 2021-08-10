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
                self.view.addSubview(self.chartView)
                self.chartView.backgroundColor = UIColor.white
                self.chartView.snp.makeConstraints { (m) in
                    m.top.equalTo(110)
                    m.centerX.equalToSuperview()
                    m.height.width.equalTo(self.view.snp.width).multipliedBy(0.95)
                }
                
                self.markerView = ChartMarkerView(chartStyle: .briefcase)
                self.view.addSubview(self.markerView)
                self.view.bringSubviewToFront(self.markerView)
                self.markerView.snp.makeConstraints { (m) in
                    self.leftChartConstraint = m.left.equalTo(self.chartView.snp.left).constraint
                    m.right.lessThanOrEqualToSuperview()
                    m.top.equalTo(self.chartView.snp.top)
                }
                self.markerView.layer.opacity = 0
                
                guard !lineChartEntry.isEmpty else { return }
                
                self.lowDateLabel.attributedText = NSAttributedString(text: self.makeDate(entry: lineChartEntry.first!), style: AttributedStringStyle.alertSubtitle)
                self.view.addSubview(self.lowDateLabel)
                self.lowDateLabel.snp.makeConstraints { (m) in
                    m.top.equalTo(self.chartView.snp.bottom)
                    m.left.equalTo(self.chartView.snp.left)
                }
                
                self.highDateLabel.attributedText = NSAttributedString(text: self.makeDate(entry: lineChartEntry.last!), style: AttributedStringStyle.alertSubtitle)
                self.view.addSubview(self.highDateLabel)
                self.highDateLabel.snp.makeConstraints { (m) in
                    m.top.equalTo(self.chartView.snp.bottom)
                    m.right.equalTo(self.chartView.snp.right)
                }
                
                self.highPriceLabel.attributedText = NSAttributedString(text: self.makeDolla(entry: arr.max()!), style: AttributedStringStyle.filterText)
                self.chartView.addSubview(self.highPriceLabel)
                self.highPriceLabel.snp.makeConstraints { (m) in
                    m.top.equalTo(self.chartView.snp.top)
                    m.right.equalTo(self.chartView.snp.right).offset(-5)
                }
                
                self.lowPriceLabel.attributedText = NSAttributedString(text: self.makeDolla(entry: arr.min()!), style: AttributedStringStyle.filterText)
                self.view.addSubview(self.lowPriceLabel)
                self.lowPriceLabel.snp.makeConstraints { (m) in
                    m.bottom.equalTo(self.chartView.snp.bottom).offset(-25)
                    m.right.equalTo(self.chartView.snp.right).offset(-5)
                }
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

class ChartsInfoViewModel {
    
    let coinId: String
    
    init(coinId: String) {
        self.coinId = coinId
    }
    
    func fetchData(completion: @escaping (ChartDataVal)->()) {
        NetworkService.shared.getChartInfo(id: self.coinId, completion: { coinData in
            completion(coinData)
        })
    }
    
}
