//
//  CoinCell.swift
//  BitHolder
//
//  Created by grigori on 09.05.2021.
//

import Foundation
import UIKit
import SnapKit

class CoinCell: UITableViewCell {
    
    let coinView = CoinView()
    
    var viewModel: CoinCellViewModel! {
        didSet {
            coinView.viewModel = viewModel
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(coinView)
        coinView.snp.makeConstraints { (m) in
            m.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //catalogView.reset()
    }
    
}
