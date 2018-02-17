//
//  SberCoinCell.swift
//  SberDEXManagement
//
//  Created by Артмеий Шлесберг on 17/02/2018.
//  Copyright © 2018 NFO. All rights reserved.
//

import Foundation
import UIKit

class SberCoinCell: UITableViewCell {
    
    private var label = StandardLabel(font: .systemFont(ofSize: 18, weight: UIFont.Weight.bold), textColor: .warmGrey, text: "Доступные средства:")
    private var addButton = StandardRoundEdgeButton()
        .with(font: .systemFont(ofSize: 18, weight: UIFont.Weight.bold))
        .with(title: "Пополнить")
        .with(titleColor: .white)
        .with(backgroundColor: .algaeGreen)
    
    
    private var amountLabel = StandardLabel(font: .systemFont(ofSize: 35, weight: UIFont.Weight.bold), textColor: .black)
    private let srLabel =  StandardLabel(font: .systemFont(ofSize: 20, weight: UIFont.Weight.bold), textColor: .black, text: "SR" )
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let separator = UIView()
        .with(backgroundColor: .sbrWhite)
        
        addSubviews([label, addButton, amountLabel, separator, srLabel] )
        
        label.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(24)
        }
        amountLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalTo(label.snp.bottom).offset(11)
        }
        srLabel.snp.makeConstraints {
            $0.bottom.equalTo(amountLabel).inset(4)
            $0.leading.equalTo(amountLabel.snp.trailing).offset(8)
        }
        addButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(240)
            $0.height.equalTo(45)
            $0.top.equalTo(amountLabel.snp.bottom).offset(18)
            $0.bottom.equalToSuperview().inset(18)
        }
        separator.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        selectionStyle = .none
      
    }
    
    func setuped(with sberWallet: Wallet) -> Self {
        amountLabel.text = "\(sberWallet.valuteAmount)SR"
        return self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
