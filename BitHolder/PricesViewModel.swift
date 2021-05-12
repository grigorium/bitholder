//
//  PricesViewModel.swift
//  BitHolder
//
//  Created by grigori on 09.05.2021.
//

import Foundation

protocol PricesViewModelDelegate: class {
    func update()
}

class PricesViewModel {
    
    weak var delegate: PricesViewModelDelegate? {
        didSet {
            start()
        }
    }
    
    var prices: [CoinData]?
    
    func start() {
        NetworkService.shared.getPricesList { [weak self] (coinData) in
            
            self?.prices = coinData
            
            self?.delegate?.update()
        }
    }
}
