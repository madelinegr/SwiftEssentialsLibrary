//
//  File.swift
//  
//
//  Created by Adam Novak on 6/26/24.
//

import Foundation

public extension URLError {
    var asDictionary: [String: Any] {
        return [
            "code": code.rawValue,
            "localizedDescription": localizedDescription,
            "failureURLString": failureURLString ?? "",
            "backgroundTaskCancelledReason": backgroundTaskCancelledReason?.rawValue ?? "",
            "networkUnavailableReason": networkUnavailableReason?.rawValue ?? "",
            "userInfo": userInfo,
            "failingURL": failingURL?.absoluteString ?? "",
            "failureURLPeerTrust": failureURLPeerTrust ?? ""
        ]
    }
}

public extension HTTPURLResponse {
    var asDictionary: [String: Any] {
        return [
            "statusCode": statusCode,
            "localizedDescription": HTTPURLResponse.localizedString(forStatusCode: statusCode),
            "expectedContentLength": expectedContentLength,
            "suggestedFilename": suggestedFilename ?? "",
            "mimeType": mimeType ?? "",
            "textEncodingName": textEncodingName ?? "",
            "url": url?.absoluteString ?? "",
            "allHeaderFields": allHeaderFields
        ]
    }
}
