//
//  Money.swift
//  BitHolder
//
//  Created by g.mashtaler on 04/05/2018.
//  Copyright © 2018 BitHolder. All rights reserved.
//

import Foundation

extension NumberFormatter {
    
    static let rubFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.locale = Locale(identifier: "ru_RU")
        f.numberStyle = .currency
        f.currencySymbol = Currency.RUB.symbol
        return f
    }()
    
    static let usdFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.locale = Locale(identifier: "ru_RU")
        f.numberStyle = .currency
        f.currencySymbol = Currency.USD.symbol
        return f
    }()
    
    static let eurFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.locale = Locale(identifier: "ru_RU")
        f.numberStyle = .currency
        f.currencySymbol = Currency.EUR.symbol
        return f
    }()
    
    static let formatterWithDecimal: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        f.locale = Locale(identifier: "ru_RU")
        return f
    }()
}

extension NSDecimalNumberHandler {
    static let decimalHandler = NSDecimalNumberHandler(roundingMode: .bankers, scale: 2, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
    static let numbersDecimalHandler = NSDecimalNumberHandler(roundingMode: .plain, scale: 2, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
}

class Money: Codable, Equatable {
    static func == (lhs: Money, rhs: Money) -> Bool {
        let leftValue = NSDecimalNumber(decimal: lhs.value).rounding(accordingToBehavior: NSDecimalNumberHandler.numbersDecimalHandler) as Decimal
        let rightValue = NSDecimalNumber(decimal: rhs.value).rounding(accordingToBehavior: NSDecimalNumberHandler.numbersDecimalHandler) as Decimal
        
        return leftValue == rightValue && lhs.currency == rhs.currency
    }
    
    
    let value: Decimal
    let currency: Currency
    lazy var part = tupleWithCurrency()
    
    init(value: Decimal, currency: Currency) {
        self.value = value
        self.currency = currency
    }
}

extension Money: CustomStringConvertible {
    
    var description: String {
        get {
            return descriptionFormatter().string(from: value as NSNumber) ?? ""
        }
    }
    
    private func descriptionFormatter() -> NumberFormatter {
        switch currency {
            case .RUB:
                return NumberFormatter.rubFormatter
            case .USD:
                return NumberFormatter.usdFormatter
            case .EUR:
                return NumberFormatter.eurFormatter
        }
    }
    
    var stringDescription: String {
        get {
            return "\(part.int)\(part.fract) \(part.currency)"
        }
    }
    
    static var zero: Money {
        return Money(value: 0, currency: .RUB)
    }
}

extension Money {
    
    private func tuple() -> (int: String, fract: String) {
        let roundedNumber = NSDecimalNumber(decimal: value).rounding(accordingToBehavior: NSDecimalNumberHandler.decimalHandler)
        let doubleValue = Double(truncating: roundedNumber as NSNumber)
        let numberString = String(format: "%.02f", doubleValue)
        let integerValue = Int(truncating: roundedNumber as NSNumber)
        guard let integerString = NumberFormatter.formatterWithDecimal.string(from: integerValue as NSNumber) else {
            return ("0","")
        }
        let numberComponent = numberString.components(separatedBy :".")
        guard numberComponent.count > 1 else {
            return (integerString, "")
        }
        let fractionalString = numberComponent[1]
        if fractionalString == "00" {
            return (integerString, "")
        }
        
        if 0 > doubleValue {
            return ("\(numberComponent[0])", ",\(fractionalString)")
        }
        return (integerString, ",\(fractionalString)")
    }
    
    fileprivate func tupleWithCurrency() -> (int: String, fract: String, currency: String) {
        let tuplePart = tuple()
        return (tuplePart.int, tuplePart.fract, currency.symbol)
    }
    
    static func +(lhs:Money, rhs:Money) -> Money {
        guard lhs.currency == rhs.currency else {
            return Money(value: 0.0, currency: lhs.currency)
        }
        let money = lhs.value + rhs.value
        return Money(value: money, currency: lhs.currency)
    }
    static func -(lhs:Money, rhs:Money) -> Money {
        guard lhs.currency == rhs.currency else {
            return Money(value: 0.0, currency: lhs.currency)
        }
        let money = lhs.value - rhs.value
        return Money(value: money, currency: lhs.currency)
    }
    static func *(lhs:Money, rhs: Decimal) -> Money {
        let value = (lhs.value as Decimal) * rhs
        return Money(value: value, currency: lhs.currency)
    }
    
    static func *(lhs:Decimal, rhs: Money) -> Money {
        let value = lhs * (rhs.value as Decimal)
        return Money(value: value, currency: rhs.currency)
    }
    static func /(lhs:Money, rhs: Decimal) -> Money {
        guard rhs != 0.00 else {
            return Money(value: 0.00, currency: lhs.currency)
        }
        let value = (lhs.value as Decimal) / rhs
        return Money(value: value, currency: lhs.currency)
    }
    static func /(lhs:Decimal, rhs: Money) -> Money {
        guard lhs != 0.00 else {
            return Money(value: 0.00, currency: rhs.currency)
        }
        let value = lhs / (rhs.value as Decimal)
        return Money(value: value, currency: rhs.currency)
    }
}
