//
//  DeleteLocalData.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2023/12/05.
//

import Foundation

public func deleteAllLocalData() {
    deleteAllDocumentDirectoryData()
    deleteAllUserDefaultData()
}

public func deleteAllDocumentDirectoryData() {
    let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    do {
        let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsUrl,
                                                                   includingPropertiesForKeys: nil,
                                                                   options: .skipsHiddenFiles)
        for fileURL in fileURLs {
            print("removing file at:", fileURL.pathExtension, fileURL.absoluteString)
            try FileManager.default.removeItem(at: fileURL)
        }
    } catch  { print(error) }
}

public func deleteAllUserDefaultData() {
    UserDefaults.standard.setPersistentDomain([:], forName: Bundle.main.bundleIdentifier!)
}
