//
//  ChartData.swift
//  BitHolder
//
//  Created by grigori on 10.08.2021.
//

import Foundation

struct ChartDataVal: Codable {
    let prices: [[Double]]
    let market_caps: [[Double]]
}

//struct ChartItem: Codable {
//    let timeStamp: Int64
//    let price: Double
//}
