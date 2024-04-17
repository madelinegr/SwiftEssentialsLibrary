//
//  Decoder+ArraySafely.swift
//  twotwotwo-ios
//
//  Created by Adam Novak on 2/15/24.
//

import Foundation

fileprivate struct DummyCodable: Codable {}

public extension UnkeyedDecodingContainer {

    mutating func decodeArray<T>(_ type: T.Type, onFail: (() -> Void)? = nil) throws -> [T] where T : Decodable {

        var array = [T]()
        while !self.isAtEnd {
            do {
                let item = try self.decode(T.self)
                array.append(item)
            } catch let error {
                print("error decoding array safely: \(error)")
                onFail?()

                // hack to increment currentIndex
                _ = try self.decode(DummyCodable.self)
            }
        }
        return array
    }
}
public extension KeyedDecodingContainerProtocol {
    func decodeSafelyArrayOf<T>(_ type: T.Type, forKey key: Self.Key, onFail: (() -> Void)? = nil) throws -> [T] where T : Decodable {
        var unkeyedContainer = try self.nestedUnkeyedContainer(forKey: key)
        return try unkeyedContainer.decodeArray(type, onFail: onFail)
    }
}
