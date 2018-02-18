//
//  StandardLabel.swift
//  DiscountMarket
//
//  Created by Timofey on 5/31/17.
//  Copyright © 2017 Jufy. All rights reserved.
//

import UIKit
import RxSwift

class StandardLabel: UILabel {
    
    
    init(font: UIFont /*= .proximaNovaRegular(ofSize: 14)*/, textColor: UIColor, text: String? = nil) {
        super.init(frame: .zero)
        self.font = font
        self.textColor = textColor
        self.numberOfLines = 0
        self.text = text
    }

    init() {
        super.init(frame: .zero)
        self.numberOfLines = 0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
