//
//  URL+Params.swift
//  PICTOCHAT
//
//  Created by Adam Novak on 5/31/23
//

import Foundation

public extension URL {
    func valueOf(_ queryParamaterName: String) -> String? {
    guard let components = URLComponents(string: self.absoluteString) else { return nil }
    return components.queryItems?.first(where: { $0.name == queryParamaterName })?.value?.removingPercentEncoding?.removingPercentEncoding
    }
}
