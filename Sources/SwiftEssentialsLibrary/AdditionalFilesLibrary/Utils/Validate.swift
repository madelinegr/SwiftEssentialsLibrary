//
//  Validate.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 5/31/23
//

import Foundation

public struct Validate {
    
    //TODO: display notice during auth that they can only use these characters
    static func validateUsername(_ username: String) -> Bool {
        var usernamePermittedCharacters: CharacterSet = [".", "_"]
        usernamePermittedCharacters.formUnion(.alphanumerics)
        let isValidUsername = usernamePermittedCharacters.isSuperset(of: CharacterSet(charactersIn: username)) && username.count > 3 && username.count <= 25
        
        return isValidUsername
    }
    
    static func validateName(_ name: String) -> Bool {
        let namePermittedCharacters: CharacterSet = .letters
        let isValidName = namePermittedCharacters.isSuperset(of: CharacterSet(charactersIn: name)) && name.count > 0 && name.count < 20
        return isValidName
    }
    
    static func validateSex(_ sex: String) -> Bool {
        return sex != "" && sex != "blank"
    }
    
    static func validateEmail(_ email: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: [.caseInsensitive])
        return regex.firstMatch(in: email, options: [], range: NSRange(location: 0, length: email.count)) != nil
    }
    
}
