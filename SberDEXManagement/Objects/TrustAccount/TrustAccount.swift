//
// Created by Timofey on 2/17/18.
// Copyright (c) 2018 NFO. All rights reserved.
//

import Foundation

protocol TrustAccount {
    
    var totalEvaluetion: Float {get}

    var portfolio: [ActivePosition] {get}
    
    var history: [Transaction] {get}

}

protocol ActivePosition {
    var titile: String {get}
    var count: Int {get}
    var price: Float {get}
}

struct ActiveFrom: ActivePosition {
    var titile: String
    
    var count: Int
    
    var price: Float
    
}

protocol Transaction {
    var date: Date {get}
    var amount: Int {get}
    var active: ActivePosition {get}
}

struct TransactionFrom: Transaction {
    var date: Date
    
    var amount: Int
    
    var active: ActivePosition
    
}


class SimpleTrustAccount: TrustAccount {
    var totalEvaluetion: Float {
        return valute + portfolio.reduce(0, {
            $0 + Float($1.count) * $1.price
        })
    }
    var valute: Float
    var portfolio: [ActivePosition] = [
        ActiveFrom(titile: "AFLT", count: 200, price: 169.2),
        ActiveFrom(titile: "GMKN", count: 114, price: 9047.62)
    ]
    
    
    var history: [Transaction] = [
        TransactionFrom(date: Date().addingTimeInterval(-1000),
                        amount: 12,
                        active: ActiveFrom(titile: "AFLT", count: 200, price: 169.2)),
        TransactionFrom(date: Date().addingTimeInterval(-1000),
                        amount: -20,
                        active: ActiveFrom(titile: "GMKN", count: 114, price: 9047.6))
    ]
    
    init(with amount: Float){
        valute = amount
    }
}
