//
// Created by Timofey on 6/28/17.
// Copyright (c) 2017 Jufy. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {

    func aligned(by alignment: NSTextAlignment) -> Self {
        self.textAlignment = alignment
        return self
    }

    func with(font: UIFont) -> Self {
        self.font = font
        return self
    }

    func with(textColor: UIColor) -> Self {
        self.textColor = textColor
        return self
    }

    func with(text: String?) -> Self {
        self.text = text
        return self
    }

    func with(text: Text) -> Self {
        self.apply(text: text)
        return self
    }

    func apply(text: Text) {
        self.attributedText = text.toAttributedString()
    }
    
    func with(numberOfLines: Int) -> Self {
        self.numberOfLines = numberOfLines
        return self
    }

}
