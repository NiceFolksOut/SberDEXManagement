//
// Created by Timofey on 1/27/18.
//

import Foundation

fileprivate class NotAnIntError: Swift.Error { }

extension Int {

    init(prefixedHexString: String) throws {
        if let int = Int(
            prefixedHexString.dropFirst(2),
            radix: 16
        ) {
            self = int
        } else {
            throw NotAnIntError()
        }
    }

    func unsignedByteWidth() -> Int {
        return (self.bitWidth - self.leadingZeroBitCount - 1).unsafeDivided(by: 8) + 1
    }

}