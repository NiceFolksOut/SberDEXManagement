//
//  UIFont.swift
//  DiscountMarket
//
//  Created by Артмеий Шлесберг on 28/06/2017.
//  Copyright © 2017 Jufy. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {

    static func ralewayRegular(ofSize size: CGFloat = 14) -> UIFont {
        return UIFont(name: "Raleway-Regular", size: size)!
    }

    static func ralewayMedium(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Raleway-Medium", size: size)!
    }

    static func ralewayBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Raleway-Bold", size: size)!
    }

}
