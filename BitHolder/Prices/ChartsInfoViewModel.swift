//
//  ChartsInfoViewModel.swift
//  BitHolder
//
//  Created by grigori on 11.08.2021.
//

import Foundation

class ChartsInfoViewModel {
    
    let coinId: String
    let ticker: String
    let coinData: CoinData
    
    init(coinData: CoinData) {
        self.coinId = coinData.id ?? "bitcoin"
        self.ticker = coinData.symbol?.uppercased() ?? "BTC"
        self.coinData = coinData
    }
    
    func fetchData(completion: @escaping (ChartDataVal)->()) {
        NetworkService.shared.getChartInfo(id: self.coinId, completion: { coinData in
            completion(coinData)
        })
    }
    
}

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal:self).doubleValue
    }
}
