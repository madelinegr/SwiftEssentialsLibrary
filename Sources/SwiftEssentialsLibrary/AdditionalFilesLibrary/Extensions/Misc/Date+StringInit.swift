//
//  Date+StringInit.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/08/28.
//

import Foundation

extension Date {
    init(string: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        self = formatter.date(from: string)!
    }
}
