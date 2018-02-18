//
// Created by Timofey on 2/17/18.
// Copyright (c) 2018 NFO. All rights reserved.
//

import Foundation

final class StickyComputation<ReturnType> {

    private let computation: () throws -> (ReturnType)
    init(computation: @escaping () throws -> (ReturnType)) {
        self.computation = computation
    }

    private var computationResult: ReturnType?
    private var error: Swift.Error?
    func result() throws -> ReturnType {
        if let computationResult = self.computationResult {
            return computationResult
        } else if let error = self.error {
            throw error
        } else {
            let computationResult = try self.computation()
            self.computationResult = computationResult
            return computationResult
        }
    }

}