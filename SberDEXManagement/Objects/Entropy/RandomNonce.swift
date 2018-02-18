//
// Created by Timofey on 2/17/18.
// Copyright (c) 2018 NFO. All rights reserved.
//

import Foundation
import Security

final class SecRandomError: Swift.Error { }

final class RandomNonce: Entropy {

    private let size: Int

    init(size: UInt) {
        self.size = Int(size)
    }

    private var cachedNonce: Data?

    func toData() throws -> Data {
        if let nonce = cachedNonce {
            return nonce
        } else {
            var randomBytes = Array<UInt8>(repeating: 0, count: size)
            if SecRandomCopyBytes(kSecRandomDefault, size, &randomBytes) == errSecSuccess {
                let nonce = Data(bytes: randomBytes)
                cachedNonce = nonce
                return nonce
            } else {
                throw SecRandomError()
            }
        }
    }

}