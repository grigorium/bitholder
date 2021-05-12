//
//  FlowController.swift
//  BitHolder
//
//  Created by grigori on 02.05.2021.
//

import Foundation
import UIKit

class FlowController {
    
    public private(set) var rootNavigationController: UINavigationController = {
        let nc = UINavigationController()
        nc.setNavigationBarHidden(true, animated: false)
        return nc
    }()
    
    private var tabBarController: UITabBarController!
    
    init() {
        presentTabBar()
    }
    
    func presentTabBar() {
        tabBarController = UITabBarController()
        tabBarController.tabBar.layer.shadowOffset = CGSize(width: 0, height: -2)
        tabBarController.tabBar.layer.shadowRadius = 10
        tabBarController.tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBarController.tabBar.layer.shadowOpacity = 0.1
        tabBarController.tabBar.tintColor = UIColor.systemGreen
        tabBarController.selectedIndex = 1
        
        let vc = MainViewController()
        firstTabNavigationController.viewControllers = [vc]
        
        let vc2 = PricesViewController()
        secondTabNavigationController.viewControllers = [vc2]
        
        let vc3 = PortfolioViewController()
        thirdTabNavigationController.viewControllers = [vc3]
        
        let vc4 = SettingsViewController()
        fourTabNavigationController.viewControllers = [vc4]
        
        tabBarController.viewControllers = [firstTabNavigationController, secondTabNavigationController, thirdTabNavigationController, fourTabNavigationController]
        
        transitionToMain()
    }
    
    
    var firstTabNavigationController = { () -> UINavigationController in
        let nc = UINavigationController()
        nc.setNavigationBarHidden(true, animated: false)
        let title = "Обзор"
        let item = UITabBarItem(title: title, image: UIImage(named: "list"), selectedImage: nil)
        item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        nc.tabBarItem = item
        return nc
    }()
    
    var secondTabNavigationController = { () -> UINavigationController in
        let nc = UINavigationController()
        nc.setNavigationBarHidden(true, animated: false)
        let title = "Цены"
        let item = UITabBarItem(title: title, image: UIImage(named: "catalog"), selectedImage: nil)
        item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        nc.tabBarItem = item
        return nc
    }()
    
    var thirdTabNavigationController = { () -> UINavigationController in
        let nc = UINavigationController()
        nc.setNavigationBarHidden(true, animated: false)
        let title = "Портфель"
        let item = UITabBarItem(title: title, image: UIImage(named: "briefcase"), selectedImage: nil)
        item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        nc.tabBarItem = item
        return nc
    }()
    
    var fourTabNavigationController = { () -> UINavigationController in
        let nc = UINavigationController()
        nc.setNavigationBarHidden(true, animated: false)
        let title = "Настройки"
        let item = UITabBarItem(title: title, image: UIImage(named: "settings"), selectedImage: nil)
        item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        nc.tabBarItem = item
        return nc
    }()
    
    
    
    
    private func transitionToMain() {
        CATransaction.begin()
        rootNavigationController.pushViewController(tabBarController, animated: true)
        rootNavigationController.setNavigationBarHidden(true, animated: false)
        CATransaction.setCompletionBlock { [weak self] in
            guard let `self` = self else { return }
            self.rootNavigationController.viewControllers = [self.tabBarController]
        }
        CATransaction.commit()
    }
}
