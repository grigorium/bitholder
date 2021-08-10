//
//  ChartsInfoViewController.swift
//  BitHolder
//
//  Created by grigori on 05.06.2021.
//

import UIKit

class ChartsInfoViewController: UIViewController {
    
    var viewModel: ChartsInfoViewModel!
    
    let backButton = UIButton(type: .custom)
    
    //let chartView = LineChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        setupBackButton()

        //setupChart()
        
        //chartView.data = ChartData(dataSet: )
    }
    
//    func setupChart() {
//
//        viewModel.fetchData { [weak self] (chartDataValue) in
//            guard let self = self else { return }
//
//            var lineChartEntry = [ChartDataEntry]()
//            let val = chartDataValue.prices
//
//            for i in 0..<val.count {
//                let value = ChartDataEntry(x: val[i][0], y: val[i][1])
//                lineChartEntry.append(value)
//            }
//
//            let line1 = LineChartDataSet(entries: lineChartEntry, label: self.viewModel.coinId)
//            line1.colors = [NSUIColor.blue]
//            line1.drawCirclesEnabled = false
//            let chartData = LineChartData()
//            chartData.addDataSet(line1)
//            chartView.chartDescription
//
//            self.chartView.data = chartData
//
//            DispatchQueue.main.async {
//                self.view.addSubview(self.chartView)
//                self.chartView.backgroundColor = UIColor.green.withAlphaComponent(0.1)
//                self.chartView.snp.makeConstraints { (m) in
//                    m.top.equalTo(150)
//                    m.centerX.equalToSuperview()
//                    m.height.width.equalTo(self.view.snp.width).multipliedBy(0.92)
//                }
//            }
//        }
//    }
    
    func setupBackButton() {
        view.addSubview(backButton)
        backButton.snp.makeConstraints { (m) in
            m.size.width.equalTo(30)
            m.left.equalTo(15)
            m.top.equalTo(48)
        }
        backButton.setBackgroundImage(UIImage(named: "arrowiosback"), for: .normal)
        backButton.addTarget(self, action: #selector(dismissVc), for: .touchUpInside)
    }
    
    @objc func dismissVc() {
        self.navigationController?.popViewController(animated: true)
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
