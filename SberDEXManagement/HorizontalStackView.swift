//
// Created by Timofey on 6/5/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import UIKit

class HorizontalStackView: UIStackView {

    final override var axis: UILayoutConstraintAxis {
        get {
            return .horizontal
        }
        set {
            super.axis = .horizontal
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .horizontal
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
