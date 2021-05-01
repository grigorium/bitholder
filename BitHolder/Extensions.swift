//
//  Extensions.swift
//  BitHolder
//
//  Created by grigori on 02.05.2021.
//

import Foundation
import UIKit

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
    
//    static func separatorView() -> UIView {
//        let v = UIView()
//        v.backgroundColor = UIColor(r: 230, g: 230, b: 230)
//        return v
//    }
}
