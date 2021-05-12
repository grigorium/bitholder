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
    
    var stats: BtcStatsData?
    
    func start() {
        NetworkService.shared.getStats(completion: { [weak self] stats in
            
            self?.stats = stats.data
            
            self?.delegate?.update()
        })
        
        //get all wallets and sum+ them
        self.delegate?.getBalance()
    }
    
    
    func getStats() -> BtcStatsData? {
        return stats
    }
    
    func getBalance() -> String {
        return "999.99"
    }
}
