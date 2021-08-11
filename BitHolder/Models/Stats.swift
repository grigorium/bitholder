//
//  Stats.swift
//  BitHolder
//
//  Created by grigori on 04.05.2021.
//

import Foundation

struct Stats: Codable {
    let blocks_size: Double
    let difficulty: Double
    let estimated_btc_sent: Double
    let estimated_transaction_volume_usd: Double
    let hash_rate: Double
    let market_price_usd: Double
    let miners_revenue_btc: Double
    let miners_revenue_usd: Double
    let minutes_between_blocks: Double
    let n_blocks_mined: Double
    let n_blocks_total: Double
    let n_btc_mined: Double
    let n_tx: Double
    let nextretarget: Double
    let timestamp: Double
    let total_btc_sent: Double
    let total_fees_btc: Double
    let totalbc: Double
    let trade_volume_btc: Double
    let trade_volume_usd: Double
}
