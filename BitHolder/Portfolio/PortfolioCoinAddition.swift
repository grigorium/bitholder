//
//  PortfolioCoinAddition.swift
//  BitHolder
//
//  Created by grigori on 05.06.2021.
//

import Foundation
import UIKit

class PortfolioCoinAdditionViewController: UIViewController, UITextFieldDelegate {
    
    var viewModel: PortfolioCoinAdditionViewModel!
    
    let amountTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        amountTextField.delegate = self
        
        view.addSubview(amountTextField)
        
        amountTextField.snp.makeConstraints { (m) in
            m.top.equalTo(110)
            m.centerX.equalToSuperview()
            m.width.equalTo(80)
        }
        
    }
    
    
    
    
}



class PortfolioCoinAdditionViewModel {
    
}
