//
//  ChartViews.swift
//  BitHolder
//
//  Created by grigori on 10.08.2021.
//

import UIKit
import SnapKit

class ChartMarkerView: UIView {
    
    private var valuesContainer: UIView = {
        let l = UIView()
        l.backgroundColor = .clear
        l.layer.cornerRadius = 2
        l.layer.borderWidth = 1
        return l
    }()
    var dateLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 12)
        l.textAlignment = .center
        return l
    }()
    var valueLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        l.textAlignment = .center
        return l
    }()
    let lineView: UIView = {
        let l = UIView()
        return l
    }()
    let circleContainerView = UIView()
    let width: CGFloat = 120.0
    let height: CGFloat = 44.0
    
    var heightOfLineConstraint: Constraint!
    var leftConstraint: Constraint!

    init(chartStyle: ChartStyle) {
        super.init(frame: .zero)
        
        valuesContainer.backgroundColor = UIColor.white
        valuesContainer.layer.borderColor = chartStyle.markerColor().cgColor
        dateLabel.textColor = chartStyle.markerColor().withAlphaComponent(0.56)
        valueLabel.textColor = chartStyle.markerColor()
        lineView.backgroundColor = chartStyle.markerColor()
        
        addSubview(valuesContainer)
        valuesContainer.snp.makeConstraints { (m) in
            m.left.top.right.equalToSuperview()
            m.width.equalTo(self.width)
            m.height.equalTo(self.height)
        }
        let stack = UIStackView(arrangedSubviews: [dateLabel, valueLabel])
        stack.axis = .vertical
        valuesContainer.addSubview(stack)
        stack.snp.makeConstraints { (m) in
            m.top.left.right.equalToSuperview()
            m.bottom.equalToSuperview().offset(-4)
        }
        addSubview(lineView)
        addSubview(circleContainerView)
        lineView.snp.makeConstraints { (m) in
            leftConstraint = m.left.equalTo(0).constraint
            m.width.equalTo(1)
            m.top.equalTo(valuesContainer.snp.bottom)
            heightOfLineConstraint = m.height.equalTo(0).constraint
        }
        circleContainerView.snp.makeConstraints { (m) in
            m.centerX.equalTo(lineView.snp.centerX)
            m.centerY.equalTo(lineView.snp.bottom)
            m.bottom.equalToSuperview()
            m.width.height.equalTo(13)
        }
        let largeCircle = UIView()
        largeCircle.backgroundColor = chartStyle.markerColor().withAlphaComponent(0.3)
        largeCircle.layer.cornerRadius = 13/2
        let smallCircle = UIView()
        smallCircle.backgroundColor = chartStyle.markerColor()
        smallCircle.layer.cornerRadius = 7/2
        circleContainerView.addSubview(largeCircle)
        largeCircle.addSubview(smallCircle)
        largeCircle.snp.makeConstraints { (m) in
            m.center.equalToSuperview()
            m.width.height.equalTo(13)
        }
        smallCircle.snp.makeConstraints { (m) in
            m.center.equalToSuperview()
            m.width.height.equalTo(7)
        }
    }
    
    func updateHeightAndLeftConstraints(height: CGFloat, left: CGFloat) {
        lineView.snp.updateConstraints { (m) in
            heightOfLineConstraint.update(offset: height)
            leftConstraint.update(offset: left)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum ChartStyle {
    case briefcase
    case company
    case exchange(pairId: Int)
    
    func axisLineColor() -> UIColor {
        switch self {
        case .briefcase: return UIColor.white.withAlphaComponent(0.1)
        case .company, .exchange: return UIColor(r: 0, g: 85, b: 187).withAlphaComponent(0.1)
        }
    }
    
    func axisValuesColor() -> UIColor {
        switch self {
        case .briefcase: return UIColor.white.withAlphaComponent(0.3)
        case .company, .exchange: return UIColor(r: 0, g: 85, b: 187).withAlphaComponent(0.3)
        }
    }
    
    func setColot() -> UIColor {
        switch self {
        case .briefcase: return .white
        case .company, .exchange: return UIColor.mainBlueColor()
        }
    }
    
    func gradientColors() -> [CGColor] {
        switch self {
        case .briefcase: return [UIColor(red: 1, green: 1, blue: 1, alpha: 0).cgColor,
                                 UIColor(red: 1, green: 1, blue: 1, alpha: 0.3).cgColor]
        case .company, .exchange: return [UIColor.mainBlueColor().withAlphaComponent(0).cgColor,
                               UIColor.mainBlueColor().withAlphaComponent(0.3).cgColor]
        }
    }
    
    func errorTextColor() -> UIColor {
        switch self {
        case .briefcase: return .white
        case .company, .exchange: return .black
        }
    }
    
    func markerColor() -> UIColor {
        switch self {
        case .briefcase: return .darkGray
        case .company, .exchange: return UIColor.mainBlueColor()
        }
    }
    
    func activityIndicatorColor() -> UIColor {
        switch self {
        case .briefcase: return .white
        case .company, .exchange: return UIColor(r: 106, g: 113, b: 125)
        }
    }
}
