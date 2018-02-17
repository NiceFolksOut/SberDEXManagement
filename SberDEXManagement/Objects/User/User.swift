//
// Created by Timofey on 2/17/18.
// Copyright (c) 2018 NFO. All rights reserved.
//

import Foundation

protocol User {

    func bankWallet() -> Wallet
    
    func sbercoinWallet() -> Wallet
    
    func trustAccount() -> TrustAccount?
    
}

class SimpleUser: User {
    
    func bankWallet() -> Wallet {
        return SimpleWallet()
    }
    
    func sbercoinWallet() -> Wallet {
        return SbercoinWallet.shared
    }
    
    func trustAccount() -> TrustAccount? {
        return UserTrusts.shared.trust
    }
}

class SimpleWallet: Wallet {
    var valuteAmount: Float = 19999.9
    
}

class SbercoinWallet: SberWallet {

    private(set) var valuteAmount: Float = 999.0

    class var shared: SbercoinWallet {
        return SbercoinWallet()
    }
    
    func makeDeposit(amount: Float) {
        valuteAmount += amount
    }
    
    func spend(amount: Float) throws {
        guard valuteAmount >= amount else {
            throw NSError()
        }
        valuteAmount -= amount
    }
}

class UserTrusts {
    
    class var shared: UserTrusts {
        return UserTrusts()
    }
    
    var trust: TrustAccount = SimpleTrustAccount(with: 200)
    
    func add(from wallet: SberWallet, with amount: Float) throws {
        try wallet.spend(amount: amount)
        trust = SimpleTrustAccount(with: amount)
    }
    
}
