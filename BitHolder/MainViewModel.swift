//
//  MainViewModel.swift
//  BitHolder
//
//  Created by grigori on 04.05.2021.
//

import Foundation

protocol MainViewModelDelegate: class {
    func getBalance()
    func update()
}

class MainViewModel {
    
    weak var delegate: MainViewModelDelegate? {
        didSet {
            start()
        }
    }
    
    var stats: Stats?
    
    func start() {
        NetworkService.shared.getStats(completion: { [weak self] stats in
            
            print(stats.market_price_usd)
            self?.stats = stats
            
            self?.delegate?.update()
        })
        
        //get all wallets and sum them
        self.delegate?.getBalance()
    }
    
    
    func getStats() -> Stats? {
        return stats
    }
    
    func getBalance() -> String {
        return "999.99"
    }
}
