//
// Created by Timofey on 2/17/18.
// Copyright (c) 2018 NFO. All rights reserved.
//

import Foundation

protocol Wallet {

    var valuteAmount: Float { get }
    
}

protocol SberWallet: Wallet {
    
    func makeDeposit(amount: Float)
    
    func spend(amount: Float) throws
    
}
