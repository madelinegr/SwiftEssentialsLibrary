//
//  UnwrapOrThrow.swift
//  AdditionalFilesLibrary
//
//  Created by Adam Novak on 4/2/24.
//

import Foundation

struct NilError: Error {
    let file: String
    let line: Int
    let column: Int
    let function: String
}

extension Optional {
    func unwrapOrThrow(file: String = #file, line: Int = #line, column: Int = #column, function: String = #function) throws -> Wrapped {
        return try unwrapOrThrow(NilError(file: file, line: line, column: column, function: function))
    }

    func unwrapOrThrow(_ error: @autoclosure () -> Error) throws -> Wrapped {
        switch self {
        case .some(let w): return w
        case .none: throw error()
        }
    }
}
