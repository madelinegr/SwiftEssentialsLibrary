//
//  FileManager+DocumentsDirectory.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/07/21.
//

import Foundation

public extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
