//
//  File.swift
//  
//
//  Created by Adam Novak on 4/5/24.
//

import Foundation

public extension String {
    mutating func appendUrlParams(_ params: [(String, String?)]) {
        for i in 0..<params.count {
            if let value = params[i].1 {
                self.append("\(i==0  ?  "?" : "&")\(params[i].0)=\(value)")
            }
        }
    }
}
