//
//  File.swift
//  DiscountMarket
//
//  Created by Артмеий Шлесберг on 13/06/2017.
//  Copyright © 2017 Jufy. All rights reserved.
//

import Foundation
import UIKit

extension UIStackView {
    
    func addArrangedSubviews(_ subviews: [UIView]) {
        for view in subviews {
            addArrangedSubview(view)
        }
    }

    func with(spacing: CGFloat) -> Self {
        self.spacing = spacing
        return self
    }

    func with(distribution: UIStackViewDistribution) -> Self {
        self.distribution = distribution
        return self
    }

    func with(alignment: UIStackViewAlignment) -> Self {
        self.alignment = alignment
        return self
    }

    func with(axis: UILayoutConstraintAxis) -> Self {
        self.axis = axis
        return self
    }

    func clear() {
        self.arrangedSubviews.forEach{ $0.removeFromSuperview() }
    }

}
