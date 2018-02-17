//
// Created by Timofey on 2/17/18.
// Copyright (c) 2018 NFO. All rights reserved.
//

import Foundation

protocol User {

    func bankWallets() -> [Wallet]
    
    func sbercoinWallets() -> [Wallet]

}