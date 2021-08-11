//
//  BtcStats.swift
//  BitHolder
//
//  Created by grigori on 08.05.2021.
//

import Foundation

struct BtcStats: Codable {
    let data: BtcStatsData
}

struct BtcStatsData: Codable {
    let blocks: Double
    let transactions: Double
    let outputs: Double
    let circulation: Double
    let blocks_24h: Double
    let transactions_24h: Double
    let difficulty: Double
    let volume_24h: Double
    let mempool_transactions: Double
    let mempool_size: Double
    let mempool_tps: Double
    let mempool_total_fee_usd: Double
    let best_block_height: Double
    let best_block_hash: String
    let best_block_time: String
    let blockchain_size: Double
    let average_transaction_fee_24h: Double
    let inflation_24h: Double
    let median_transaction_fee_24h: Double
    let cdd_24h: Double
    let nodes: Double
    let hashrate_24h: String
    let inflation_usd_24h: Double
    let average_transaction_fee_usd_24h: Double
    let median_transaction_fee_usd_24h: Double
    let market_price_usd: Double
    let market_price_btc: Double
    let market_price_usd_change_24h_percentage: Double
    let market_cap_usd: Double
    let market_dominance_percentage: Double
    let next_retarget_time_estimate: String
    let next_difficulty_estimate: Double
}
