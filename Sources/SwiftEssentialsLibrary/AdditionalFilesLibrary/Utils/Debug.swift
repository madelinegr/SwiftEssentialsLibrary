//
//  Debug.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/09/05.
//

import Foundation

public func debug(file: String = #file, line: Int = #line, function: String = #function) -> String {
    return "\(file):\(line) : \(function)"
}
