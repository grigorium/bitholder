//
//  Extensions.swift
//  BitHolder
//
//  Created by grigori on 02.05.2021.
//

import Foundation
import UIKit

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter
    }()
}

extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}

extension UIImage {
    
    convenience init(view: UIView) {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in:UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: image!.cgImage!)
    }
    
    static func tabBarShadowImage() -> UIImage {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1))
        view.backgroundColor = UIColor(red: 230, green: 230, blue: 230, alpha: 1)
        return UIImage(view: view)
    }
}

extension UIView {
    
    func setupMotionEffect(value: CGFloat = 15) {
        
        let verticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y",
                                                               type: .tiltAlongVerticalAxis)
        verticalMotionEffect.minimumRelativeValue = -value
        verticalMotionEffect.maximumRelativeValue = value
        let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x",
                                                                 type: .tiltAlongHorizontalAxis)
        horizontalMotionEffect.minimumRelativeValue = -value
        horizontalMotionEffect.maximumRelativeValue = value
        let group = UIMotionEffectGroup()
        group.motionEffects = [horizontalMotionEffect, verticalMotionEffect]
        self.addMotionEffect(group)
    }

    static func separatorView() -> UIView {
        let v = UIView()
        v.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        return v
    }
}

extension UIColor {
    
    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) {
        self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: a)
    }
    
    static func mainBlueColor() -> UIColor {
        return UIColor(red: 74/255, green: 143/255, blue: 226/255, alpha: 1.0)
    }
    
    static func selectedBlueColor() -> UIColor {
        return UIColor(red: 60/255, green: 130/255, blue: 214/255, alpha: 1.0)
    }
    
    static func grayTextColor() -> UIColor {
        return UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0)
    }
    
    static func lightGrayButtonDefaultColor() -> UIColor {
        return UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
    }
    
    static func lightGrayButtonSelectedColor() -> UIColor {
        return UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0)
    }
    
    static func tabBarSeparatorColor() -> UIColor {
        return UIColor(r: 230, g: 230, b: 230)
    }
    
    static func pinInputButtonGraySelectedColor() -> UIColor {
        return UIColor(r: 245, g: 245, b: 245)
    }
    
    static func errorBackgroundColor() -> UIColor {
        return UIColor(r: 245, g: 245, b: 245)
    }
    
    static func pinInputButtonWhiteSelectedColor() -> UIColor {
        return UIColor.white.withAlphaComponent(0.1)
    }
    
    static var circleGreyColor: UIColor = {
        return UIColor(r: 230, g: 230, b: 230)
    }()
    
    static var circleBlueColor: UIColor = {
        return UIColor(r: 74, g: 143, b: 226)
    }()
    
    static func lightGrayTableViewSeparatorColor() -> UIColor {
        return UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
    }

    static var currencyGreenColor: UIColor = {
        return UIColor(r: 75, g: 189, b: 92)
    }()
    
    static var currencyRedColor: UIColor = {
        return UIColor(r: 208, g: 2, b: 27)
    }()
    static var officialApplePlaceholderGray: UIColor = {
        return UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
    }()
}

extension UIColor {
    
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
       
        //let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        //let scanner = Scanner(string: hexString)
//        if (hexString.hasPrefix("#")) {
//            scanner.scanLocation = 1
//        }
        let color: UInt32 = 0
        //scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}


enum AttributedStringStyle {
    case offertaTextStyle
    case offertaLinkTextStyle
    case stockCellName
    case stockCellAmount
    case stockCellMoney
    case stockCellPercentPlus
    case stockCellPercentMinus
    case stockCellPercentPlusCentered
    case stockCellPercentMinusCentered
    case tableViewHeader
    case catalogHeader
    case boldHeader
    case regularHeader
    case regularHeaderError
    case bannerDescription
    case briefCasePrice
    case heavyMoney
    case lightMoney
    case briefcaseProfit
    case expandChart
    case historyCellAction
    case filterText
    case historyCellMoneyIncome
    case historyCellMoneyLoss
    case historyCellFailed
    case subtitle
    case investIdea
    case purchaseAmountValue
    case purchaseAmountBoldValue
    case purchasedStocks
    case purchasedStocksSubtitle
    case companyDescription
    case emptyTabCell
    case tradingAssetSummaryTitleDescription
    case tradingAssetSummaryTitle
    case tradingAssetSummaryTitleiPhonePlus
    case tradingAssetSummaryStocksPercentPlus
    case tradingAssetSummaryStocksPercentPlusiPhonePlus
    case tradingAssetSummaryStocksMinus
    case tradingAssetSummaryStocksMinusiPhonePlus
    case orderWaiting
    case accountOperationsBalance
    case refillOptions
    case documentsLabel
    case indentificationResultTitle
    case indentificationResultSubtitle
    case investIdeaTitle
    case heightLine8
    case heightLine20
    case investIdeaDetailTitle
    case newsCellDate
    case newsCellHeader
    case newsCellArticle
    case investIdeaDate
    case investIdeaPercentPlus
    case investIdeaPercentMinus
    case investIdeaStatisticLabel
    
    case profilePlaceHolder
    case profileValue
    case newsHeader
    case documentScanInstructions
    case alertTitle
    case alertSubtitle
    case alertSubtitleBlue
    
    case profileDemo
    case briefcaseDemo
    case nonAuth
    case billWillBeOpen
}

extension NSAttributedString {
    
    convenience init(text: String, style: AttributedStringStyle) {
        let dictionary = NSAttributedString.createDictionary(fromStyle: style)
        self.init(string: text, attributes: dictionary)
    }
    
    static func createDictionary(fromStyle style: AttributedStringStyle) -> [NSAttributedString.Key: Any] {
    
        switch style {
            case .offertaTextStyle:
                return createDictionary(font: UIFont.systemFont(ofSize: 12), color: UIColor.grayTextColor(), lineHeight: 14, alignment: .center)
            case .offertaLinkTextStyle:
                return createDictionary(font: UIFont.systemFont(ofSize: 12), color: UIColor.mainBlueColor(), lineHeight: 14, alignment: .center)
            case .stockCellName:
                return createDictionary(font: UIFont.systemFont(ofSize: 14, weight: .medium), color: UIColor(r: 0, g: 0, b: 0, a: 0.87), lineHeight: 16, alignment: .left)
            case .stockCellAmount:
                return createDictionary(font: UIFont.systemFont(ofSize: 12), color: UIColor.grayTextColor(), lineHeight: 16, alignment: .left)
            case .stockCellMoney:
                return createDictionary(font: UIFont.systemFont(ofSize: 14, weight: .medium), color: UIColor(r: 0, g: 0, b: 0, a: 0.87), lineHeight: 16, alignment: .left)
            case .stockCellPercentPlus:
                return createDictionary(font: UIFont.systemFont(ofSize: 12), color: UIColor(r: 39, g: 185, b: 60), lineHeight: 16, alignment: .right)
            case .stockCellPercentMinus:
                return createDictionary(font: UIFont.systemFont(ofSize: 12), color: UIColor(r: 208, g: 2, b: 27), lineHeight: 16, alignment: .right)
        case .stockCellPercentPlusCentered:
            return createDictionary(font: UIFont.systemFont(ofSize: 12), color: UIColor(r: 39, g: 185, b: 60), lineHeight: 16, alignment: .center)
        case .stockCellPercentMinusCentered:
            return createDictionary(font: UIFont.systemFont(ofSize: 12), color: UIColor(r: 208, g: 2, b: 27), lineHeight: 16, alignment: .center)
        case .tableViewHeader:
            return createDictionary(font: UIFont.systemFont(ofSize: 12, weight: .medium), color: UIColor.grayTextColor(), lineHeight: 16, alignment: .left, kern: 0.5)
            case .boldHeader:
                return createDictionary(font: UIFont.systemFont(ofSize: 16, weight: .bold), color: UIColor(r: 0, g: 0, b: 0, a: 0.87), lineHeight: 24, alignment: .center)
        case .regularHeader:
            return createDictionary(font: UIFont.systemFont(ofSize: 16, weight: .regular), color: UIColor(r: 0, g: 0, b: 0), lineHeight: 24, alignment: .left)
        case .regularHeaderError:
            return createDictionary(font: UIFont.systemFont(ofSize: 16, weight: .regular), color: UIColor(r: 208, g: 2, b: 27), lineHeight: 24, alignment: .left)
            case .bannerDescription:
                return createDictionary(font: UIFont.systemFont(ofSize: 14), color: UIColor(r: 0, g: 0, b: 0, a: 0.38), lineHeight: 20, alignment: .center)
            case .briefCasePrice:
                return createDictionary(font: UIFont.systemFont(ofSize: 12, weight: .semibold), color: UIColor(r: 255, g: 255, b: 255, a: 0.5), lineHeight: 20, alignment: .center)
            case .heavyMoney:
                return createDictionary(font: UIFont.systemFont(ofSize: 36, weight: .heavy), color: UIColor(r: 255, g: 255, b: 255), lineHeight: 40, alignment: .center)
            case .lightMoney:
                return createDictionary(font: UIFont.systemFont(ofSize: 36, weight: .light), color: UIColor(r: 255, g: 255, b: 255), lineHeight: 40, alignment: .center)
            case .briefcaseProfit:
                return createDictionary(font: UIFont.systemFont(ofSize: 12, weight: .semibold), color: UIColor(r: 255, g: 255, b: 255), lineHeight: 12, alignment: .center)
            case .expandChart:
                return createDictionary(font: UIFont.systemFont(ofSize: 12), color: UIColor(r: 255, g: 255, b: 255, a: 0.9), lineHeight: 16, alignment: .center)
        case .filterText:
            return createDictionary(font: UIFont.systemFont(ofSize: 16), color: UIColor(r: 0, g: 0, b: 0), lineHeight: 24, alignment: .left, kern: -0.3)
        case .historyCellMoneyIncome:
            return createDictionary(font: UIFont.systemFont(ofSize: 14, weight: .semibold), color: UIColor(r: 75, g: 189, b: 92), lineHeight: 16, alignment: .right)
        case .historyCellMoneyLoss:
            return createDictionary(font: UIFont.systemFont(ofSize: 14, weight: .semibold), color: UIColor(r: 0, g: 0, b: 0, a: 0.87), lineHeight: 16, alignment: .right)
        case .historyCellFailed:
            return createDictionary(font: UIFont.systemFont(ofSize: 14), color: UIColor(r: 153, g: 153, b: 153), lineHeight: 16, alignment: .right)
        case .historyCellAction:
            return createDictionary(font: UIFont.systemFont(ofSize: 14, weight: .regular), color: UIColor(r: 0, g: 0, b: 0, a: 0.87), lineHeight: 16, alignment: .left)
        case .subtitle:
            return createDictionary(font: UIFont.systemFont(ofSize: 12, weight: .regular), color: UIColor(r: 0, g: 0, b: 0, a: 0.6), lineHeight: 18, alignment: .center, kern: -0.1)
        case .investIdea:
            return createDictionary(font: UIFont.systemFont(ofSize: 14, weight: .medium), color: UIColor(r: 255, g: 255, b: 255), lineHeight: 16, alignment: .center, kern: -0.3)
        case .catalogHeader:
            return createDictionary(font: UIFont.systemFont(ofSize: 18, weight: .heavy), color: .black, lineHeight: 18, alignment: .left, kern: -0.4)
        case .purchaseAmountValue:
            return createDictionary(font: UIFont.systemFont(ofSize: 12), color: .black, lineHeight: 16, alignment: .left)
        case .purchaseAmountBoldValue:
            return createDictionary(font: UIFont.systemFont(ofSize: 12, weight: .bold), color: .black, lineHeight: 16, alignment: .left)
        case .purchasedStocks:
            return createDictionary(font: UIFont.systemFont(ofSize: 20, weight: .bold), color: .black, lineHeight: 24, alignment: .center)
        case .purchasedStocksSubtitle:
            return createDictionary(font: UIFont.systemFont(ofSize: 14), color: .black, lineHeight: 20, alignment: .center, kern: -0.2)
        case .companyDescription:
            return createDictionary(font: UIFont.systemFont(ofSize: 12), color: UIColor.black, lineHeight: 18)
        case .emptyTabCell:
            return createDictionary(font: UIFont.systemFont(ofSize: 14), color: UIColor.grayTextColor(),  lineHeight: 18, alignment: .center, kern: -0.2)
        case .tradingAssetSummaryTitleDescription:
            return createDictionary(font: UIFont.systemFont(ofSize: 12, weight: .regular), color: UIColor(r: 153, g: 153, b: 153), lineHeight: 12)
        case .tradingAssetSummaryTitle:
            return createDictionary(font: UIFont.systemFont(ofSize: 12, weight: .semibold), color: UIColor(r: 0, g: 0, b: 0, a: 0.87), lineHeight: 16)
        case .tradingAssetSummaryTitleiPhonePlus:
            return createDictionary(font: UIFont.systemFont(ofSize: 16, weight: .semibold), color: UIColor(r: 0, g: 0, b: 0, a: 0.87), lineHeight: 20)
        case .tradingAssetSummaryStocksPercentPlus:
            return createDictionary(font: UIFont.systemFont(ofSize: 12, weight: .semibold), color: UIColor(r: 39, g: 185, b: 60), lineHeight: 16)
        case .tradingAssetSummaryStocksPercentPlusiPhonePlus:
            return createDictionary(font: UIFont.systemFont(ofSize: 16, weight: .semibold), color: UIColor(r: 39, g: 185, b: 60), lineHeight: 20)
        case .tradingAssetSummaryStocksMinus:
            return createDictionary(font: UIFont.systemFont(ofSize: 12, weight: .semibold), color: UIColor(r: 208, g: 2, b: 27), lineHeight: 16)
        case .tradingAssetSummaryStocksMinusiPhonePlus:
            return createDictionary(font: UIFont.systemFont(ofSize: 16, weight: .semibold), color: UIColor(r: 208, g: 2, b: 27), lineHeight: 20)
        case .orderWaiting:
            return createDictionary(font: UIFont.systemFont(ofSize: 14, weight: .regular), color: .black, lineHeight: 18, alignment: .center)
        case .accountOperationsBalance:
            return createDictionary(font: UIFont.systemFont(ofSize: 26, weight: .bold), color: .black, lineHeight: 31, alignment: .center, kern: -0.4)
        case .refillOptions:
            return createDictionary(font: UIFont.systemFont(ofSize: 14), color: UIColor.grayTextColor(), lineHeight: 20, alignment: .left, kern: -0.2)
        case .documentsLabel:
            return createDictionary(font: UIFont.systemFont(ofSize: 14), color: UIColor(r: 0, g: 0, b: 0, a: 0.87), lineHeight: 20, alignment: .left)
        case .indentificationResultTitle:
            return createDictionary(font: UIFont.systemFont(ofSize: 20, weight: .bold), color: UIColor.black, lineHeight: 24, alignment: .center, kern: 0.4)
        case .indentificationResultSubtitle:
            return createDictionary(font: UIFont.systemFont(ofSize: 14), color: UIColor(r: 153, g: 153, b: 153, a: 0.87), lineHeight: 20, alignment: .center)
        case .investIdeaTitle:
            return createDictionary(font: UIFont.systemFont(ofSize: 20, weight: .bold), color: .black, lineHeight: 20, alignment: .left)
        case .heightLine8:
            return createDictionary(font: UIFont.systemFont(ofSize: 8), color: .black, lineHeight: 8, alignment: .left)
        case .heightLine20:
            return createDictionary(font: UIFont.systemFont(ofSize: 20), color: .black, lineHeight: 20, alignment: .left)
        case .investIdeaDetailTitle:
            return createDictionary(font: UIFont.systemFont(ofSize: 28, weight: .bold), color: UIColor(r: 255, g: 255, b: 255), lineHeight: 32)
        case .newsCellDate:
            return createDictionary(font: UIFont.systemFont(ofSize: 12, weight: .medium), color: UIColor(r: 0, g: 0, b: 0, a : 0.38), lineHeight: 16, alignment: .left)
        case .newsCellHeader:
            return createDictionary(font: UIFont.systemFont(ofSize: 18, weight: .bold), color: .black, lineHeight: 22, alignment: .left, kern: -0.2)
        case .newsCellArticle:
            return createDictionary(font: UIFont.systemFont(ofSize: 12, weight: .regular), color: UIColor(r: 255, g: 255, b: 255, a: 1), lineHeight: 18)
        case .investIdeaDate:
            return createDictionary(font: UIFont.systemFont(ofSize: 12, weight: .semibold), color: UIColor(r: 255, g: 255, b: 255, a: 1), lineHeight: 18, alignment: .right)
        case .investIdeaPercentPlus:
            return createDictionary(font: UIFont.systemFont(ofSize: 18, weight: .bold), color: UIColor(r: 39, g: 185, b: 60), lineHeight: 24)
        case .investIdeaPercentMinus:
            return createDictionary(font: UIFont.systemFont(ofSize: 18, weight: .bold), color: UIColor(r: 208, g: 2, b: 27), lineHeight: 24)
        case .investIdeaStatisticLabel:
            return createDictionary(font: UIFont.systemFont(ofSize: 12, weight: .medium), color: UIColor.grayTextColor(), lineHeight: 15, alignment: .left)
        case .profilePlaceHolder:
            return createDictionary(font: UIFont.systemFont(ofSize: 14), color: UIColor(r: 0, g: 0, b: 0, a: 0.38), lineHeight: 20, alignment: .left)
        case .profileValue:
            return createDictionary(font: UIFont.systemFont(ofSize: 16, weight: .regular), color: UIColor(r: 0, g: 0, b: 0, a: 0.87), lineHeight: 24)
        case .newsHeader:
            return createDictionary(font: UIFont.systemFont(ofSize: 22, weight: .bold), color: .black, lineHeight: 24, alignment: .left, kern: -0.2)
        case .documentScanInstructions:
            return createDictionary(font: UIFont.systemFont(ofSize: 12, weight: .regular), color: UIColor(r: 153, g: 153, b: 153), lineHeight: 16, alignment: .left)
        case .alertTitle:
            return createDictionary(font: UIFont.systemFont(ofSize: 16, weight: .medium), color: UIColor(r: 0, g: 0, b: 0, a: 0.87), lineHeight: 24, alignment: .center)
        case .alertSubtitle:
            return createDictionary(font: UIFont.systemFont(ofSize: 12), color: UIColor(r: 0, g: 0, b: 0, a: 0.38), lineHeight: 16, alignment: .center)
        case .alertSubtitleBlue:
            return createDictionary(font: UIFont.systemFont(ofSize: 12), color: UIColor(r: 73, g: 143, b: 226), lineHeight: 16, alignment: .center)
        case .profileDemo:
                return createDictionary(font: UIFont.systemFont(ofSize: 16), color: UIColor(r: 0, g: 0, b: 0), lineHeight: 24, alignment: .center)
        case .briefcaseDemo:
            return createDictionary(font: UIFont.systemFont(ofSize: 14), color: UIColor(r: 255, g: 255, b: 255), lineHeight: 20, alignment: .center)
        case .nonAuth:
            return createDictionary(font: UIFont.systemFont(ofSize: 13), color: UIColor.black, lineHeight: 16, alignment: .center)
        case .billWillBeOpen:
            return createDictionary(font: UIFont.systemFont(ofSize: 20, weight: .bold), color: UIColor.white, lineHeight: 24, alignment: .center)
        }
    }
    
    private static func createDictionary(font: UIFont, color: UIColor, lineBreakMode: NSLineBreakMode = .byTruncatingTail, lineHeight: CGFloat, alignment: NSTextAlignment = .left, kern: CGFloat? = nil) -> [NSAttributedString.Key: Any] {
        let para = NSMutableParagraphStyle()
        para.lineBreakMode = lineBreakMode
        para.maximumLineHeight = lineHeight
        para.minimumLineHeight = lineHeight
        para.alignment = alignment
        var result: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: color,
            NSAttributedString.Key.paragraphStyle: para
        ]
        if let k = kern {
            result[NSAttributedString.Key.kern] = k
        }
        return result
    }
}

