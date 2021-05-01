//
//  ViewController.swift
//  BitHolder
//
//  Created by grigori on 30.04.2021.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    
    let mountainsImageView: UIImageView = {
        let i = UIImageView(image: UIImage(named: "mountainMiat"))
        i.contentMode = .scaleAspectFill
        return i
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(mountainsImageView)
        mountainsImageView.snp.makeConstraints { (m) in
            m.center.equalToSuperview()
            m.height.equalToSuperview().multipliedBy(1.6)
            m.width.equalToSuperview().multipliedBy(1.4)
        }
        mountainsImageView.setupMotionEffect()
    }
    

    
}
