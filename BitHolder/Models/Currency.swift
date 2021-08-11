//
//  Currency.swift
//  BitHolder
//
//  Created by g.mashtaler on 24/05/2018.
//  Copyright © 2018 BitHolder. All rights reserved.
//

import Foundation
import UIKit

enum Currency: String, Codable, Equatable {
    case RUB
    case USD
    case EUR
    
    private static let knownCurrenciesStrings: [String: Currency] = ["RUB": .RUB, "EUR": .EUR, "USD": .USD]
    private static let knownCurrenciesCodes: [Int: Currency] = [643: .RUB, 978: .EUR, 840: .USD]
    
    init(from decoder: Decoder) throws {
        if let value = try? decoder.singleValueContainer().decode(String.self), let currency = Currency.knownCurrenciesStrings[value] ?? Currency.knownCurrenciesCodes[Int(value) ?? -1] {
            self = currency
        } else if let value = try? decoder.singleValueContainer().decode(Int.self), let currency = Currency.knownCurrenciesCodes[value] {
            self = currency
        } else {
            throw NSError(domain: "Limits", code: 1, userInfo: [NSLocalizedDescriptionKey: "unknown currency"])
        }
    }
    
    func currencyCode() -> Int {
        let filtered = Currency.knownCurrenciesCodes.filter { $0.value == self }
        if let keyValue = filtered.first {
            return keyValue.key
        }
        return 840
    }
}

extension Currency {
    
    var symbol: String {
        switch self {
        case .RUB: return "₽"
        case .USD: return "$"
        case .EUR: return "€"
        }
    }

    var description: String {
        switch self {
        case .RUB: return "Рубли"
        case .USD: return "Доллары США"
        case .EUR: return "Евро"
        }
    }
    
    var sellPriceForAmountText: String {
        switch self {
        case .RUB: return ""
        default: return "Сумма продажи"
        }
    }
    
    var buyPriceForAmountText: String {
        switch self {
        case .RUB: return ""
        default: return "Сумма покупки"
        }
    }
    
    var priceForOneText: String {
        switch self {
        case .RUB: return "за рубль"
        case .USD: return "за доллар США"
        case .EUR: return "за евро"
        }
    }
    
    var imageName: String {
        switch self {
        case .USD: return "Dollar"
        case .EUR: return "Euro"
        case .RUB: return "Ruble"
        }
    }
    
    var bigImageName: String {
        switch self {
        case .USD: return "Dollar-big"
        case .EUR: return "Euro-big"
        case .RUB: return "Ruble-big"
        }
    }
}
