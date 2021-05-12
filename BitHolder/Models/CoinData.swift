//
//  CoinData.swift
//  BitHolder
//
//  Created by grigori on 09.05.2021.
//

import Foundation

//"id": "bitcoin",
//"symbol": "btc",
//"name": "Bitcoin",
//"image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
//"current_price": 59001,
//"market_cap": 1106234606864,
//"market_cap_rank": 1,
//"fully_diluted_valuation": 1242039036866,
//"total_volume": 67795130382,
//"high_24h": 59504,
//"low_24h": 56985,
//"price_change_24h": 1471.06,
//"price_change_percentage_24h": 2.55705,
//"market_cap_change_24h": 26008333392,
//"market_cap_change_percentage_24h": 2.40767,
//"circulating_supply": 18703862,
//"total_supply": 21000000,
//"max_supply": 21000000,
//"ath": 64805,
//"ath_change_percentage": -8.62467,
//"ath_date": "2021-04-14T11:54:46.763Z",
//"atl": 67.81,
//"atl_change_percentage": 87226.9455,
//"atl_date": "2013-07-06T00:00:00.000Z",
//"roi": null,
//"last_updated": "2021-05-08T20:52:40.633Z",
//"price_change_percentage_24h_in_currency": 2.557048585993226

struct CoinData: Codable {
    let id: String?
    let symbol: String?
    let name: String?
    let image: String?
    let current_price: Decimal?
    let market_cap: Decimal?
    let market_cap_rank: Int?
    let fully_diluted_valuation: Decimal?
    let total_volume: Decimal?
    let high_24h: Decimal?
    let low_24h: Decimal?
    let price_change_24h: Decimal?
    let price_change_percentage_24h: Decimal?
    let market_cap_change_24h: Decimal?
    let market_cap_change_percentage_24h: Decimal?
    let circulating_supply: Decimal?
    let total_supply: Decimal?
    let max_supply: Decimal?
    let ath: Decimal?
    let ath_change_percentage: Decimal?
    let ath_date: String?
    let atl: Decimal?
    let atl_change_percentage: Decimal?
    let atl_date: String?
    let last_updated: String?
    let price_change_percentage_24h_in_currency: Decimal?
}
