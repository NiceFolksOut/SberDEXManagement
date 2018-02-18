//
// Created by Timofey on 1/28/18.
//

import Foundation
import CryptoSwift

extension Data {

    init(integer: UInt) {
        var integerCopy = integer
        self = Data(
            bytes: &integerCopy,
            count: MemoryLayout.size(ofValue: integerCopy)
        )
    }

    init(concatenating data: [Data]) {
        self = data.reduce(Data()) { $0 + $1 }
    }

    init(hexString: String) {

        if hexString.count % 2 == 0 {
            self = Data(hex: hexString.removingHexPrefix())
        } else {
            self = Data(hex: "0" + hexString.removingHexPrefix())
        }

    }

    func droppingLeadingZeroes() -> Data {
        return self.dropLast().drop(while: { $0 == 0 }) + [self.last].flatMap{$0}
    }

}