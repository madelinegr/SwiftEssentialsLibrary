//
//  String+ValidURL.swift
//  
//
//  Created by Adam Novak on 7/12/24.
//

import Foundation

public extension String {
    
    var isValidURLWithoutPercentEncoding: Bool {
        let allowedCharacters = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~:/?#[]@!$&'()*+,;=%")
        return self.rangeOfCharacter(from: allowedCharacters.inverted) == nil
    }
    
}
