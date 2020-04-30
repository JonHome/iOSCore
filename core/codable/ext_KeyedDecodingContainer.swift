//
//  ext_KeyedDecodingContainer.swift
//  core
//
//  Created by Jon Home on 2018/6/15.
//  Copyright © 2018年 homebit. All rights reserved.
//

import Foundation
import CoreGraphics


public extension KeyedDecodingContainer {
    func decodeWrapper<T>(key: K, defaultValue: T) throws -> T
        where T : Decodable {
            return try decodeIfPresent(T.self, forKey: key) ?? defaultValue
    }
    
    func decodeIfPresentUnwrapper<T>(key: K, onNotNil: ((T) -> Void)) throws where T : Decodable {
        if let t = try decodeIfPresent(T.self, forKey: key){
            onNotNil(t)
        }
    }
    
    func decode<T>(forKey key: KeyedDecodingContainer.Key) throws -> T where T : Decodable{
        return try self.decode(T.self, forKey: key)
    }
    
    
    func decodeIfPresent<T>(forKey key: KeyedDecodingContainer.Key) throws -> T? where T : Decodable{
        return try self.decodeIfPresent(T.self, forKey: key)
    }

    @discardableResult
    func decodeOnlyPresentWithNotNil<T>(forKey key: KeyedDecodingContainer.Key, point:inout T?) throws -> T? where T : Decodable{
        if let t : T = try self.decodeIfPresent(forKey: key){
            point = t
            return t
        }
        return nil
    }
    
    @discardableResult
    func maydecodeOnlyPresentWithNotNil<T>(forKey key: KeyedDecodingContainer.Key, point:inout T?) -> T? where T : Decodable{
        return try? self.decodeOnlyPresentWithNotNil(forKey: key, point: &point)
    }
    
    @discardableResult
    func decodeOnlyPresentWithNotNil<T>(forKey key: KeyedDecodingContainer.Key, point:inout T?, defaultValue: T? = nil) -> T? where T : Decodable{
        if let t : T = try? self.decodeOnlyPresentWithNotNil(forKey: key, point: &point){
            return t
        } else{
            point = defaultValue
            return defaultValue
        }
    }
    
    @discardableResult
    func decodeOnlyPresentWithNotNil<T>(forKey key: KeyedDecodingContainer.Key, point:inout T) throws -> T? where T : Decodable{
        if let t : T = try self.decodeIfPresent(forKey: key){
            point = t
            return t
        }
        return nil
    }
    
    @discardableResult
    func maydecodeOnlyPresentWithNotNil<T>(forKey key: KeyedDecodingContainer.Key, point:inout T) -> T? where T : Decodable{
        return try? self.decodeOnlyPresentWithNotNil(forKey: key, point: &point)
    }
    
    @discardableResult
    func decodeOnlyPresentWithNotNil<T>(forKey key: KeyedDecodingContainer.Key, point:inout T, defaultValue: T) -> T? where T : Decodable{
        if let t : T = try? self.decodeOnlyPresentWithNotNil(forKey: key, point: &point){
            point = t
            return t
        } else{
            point = defaultValue
            return defaultValue
        }
    }
    
}


public extension KeyedDecodingContainer {
    
    func decode(_ type: Dictionary<String, Any>.Type, forKey key: K) throws -> Dictionary<String, Any> {
        let container = try self.nestedContainer(keyedBy: JSONCodingKeys.self, forKey: key)
        return try container.decode(type)
    }
    
    func decode(_ type: Array<Any>.Type, forKey key: K) throws -> Array<Any> {
        var container = try self.nestedUnkeyedContainer(forKey: key)
        return try container.decode(type)
    }
    
    
    func decode(_ type: Dictionary<String, Any>.Type) throws -> Dictionary<String, Any> {
        var dictionary = Dictionary<String, Any>()
        
        for key in allKeys {
            if let boolValue = try? decode(Bool.self, forKey: key) {
                dictionary[key.stringValue] = boolValue
            } else if let stringValue = try? decode(String.self, forKey: key) {
                dictionary[key.stringValue] = stringValue
            } else if let intValue = try? decode(Int.self, forKey: key) {
                dictionary[key.stringValue] = intValue
            } else if let doubleValue = try? decode(Double.self, forKey: key) {
                dictionary[key.stringValue] = doubleValue
            } else if let nestedDictionary = try? decode(Dictionary<String, Any>.self, forKey: key) {
                dictionary[key.stringValue] = nestedDictionary
            } else if let nestedArray = try? decode(Array<Any>.self, forKey: key) {
                dictionary[key.stringValue] = nestedArray
            }
        }
        return dictionary
    }
}

public extension UnkeyedDecodingContainer {
    
    mutating func decode(_ type: Array<Any>.Type) throws -> Array<Any> {
        var array: [Any] = []
        while isAtEnd == false {
            if let value = try? decode(Bool.self) {
                array.append(value)
            } else if let value = try? decode(Double.self) {
                array.append(value)
            } else if let value = try? decode(String.self) {
                array.append(value)
            } else if let nestedDictionary = try? decode(Dictionary<String, Any>.self) {
                array.append(nestedDictionary)
            } else {
                do{
                    var nestedContainer = try self.nestedUnkeyedContainer()
                    let nestedArray = try nestedContainer.decode(Array<Any>.self)
                    array.append(nestedArray)
                } catch{
                    print("catch:\(error)")
                }
                
//                array.append(nestedArray)
            }
        }
        return array
    }
    
    mutating func decode(_ type: Dictionary<String, Any>.Type) throws -> Dictionary<String, Any> {
        let nestedContainer = try self.nestedContainer(keyedBy: JSONCodingKeys.self)
        return try nestedContainer.decode(type)
    }
}


public extension KeyedEncodingContainerProtocol where Key == JSONCodingKeys {
    mutating func encode(_ value: Dictionary<String, Any>) throws {
        try value.forEach({ (key, value) in
            let key = JSONCodingKeys(stringValue: key)
            switch value {
            case let value as Bool:
                try encode(value, forKey: key)
            case let value as Int:
                try encode(value, forKey: key)
            case let value as String:
                try encode(value, forKey: key)
            case let value as Double:
                try encode(value, forKey: key)
            case let value as CGFloat:
                try encode(value, forKey: key)
            case let value as Dictionary<String, Any>:
                try encode(value, forKey: key)
            case let value as Array<Any>:
                try encode(value, forKey: key)
            case Optional<Any>.none:
                try encodeNil(forKey: key)
            default:
                throw EncodingError.invalidValue(value, EncodingError.Context(codingPath: codingPath + [key], debugDescription: "Invalid JSON value"))
            }
        })
    }
}



// original https://gist.github.com/loudmouth/332e8d89d8de2c1eaf81875cfcd22e24
public struct JSONCodingKeys: CodingKey {
    public var stringValue: String
    
    public init(stringValue: String) {
        self.stringValue = stringValue
    }
    
    public var intValue: Int?
    
    public init?(intValue: Int) {
        self.init(stringValue: "\(intValue)")
        self.intValue = intValue
    }
}


public extension KeyedEncodingContainerProtocol {
    mutating func encode(_ value: Dictionary<String, Any>?, forKey key: Key) throws {
        if value != nil {
            var container = self.nestedContainer(keyedBy: JSONCodingKeys.self, forKey: key)
            try container.encode(value!)
        }
    }
    
    mutating func encode(_ value: Array<Any>?, forKey key: Key) throws {
        if value != nil {
            var container = self.nestedUnkeyedContainer(forKey: key)
            try container.encode(value!)
        }
    }
}

public extension UnkeyedEncodingContainer {
    mutating func encode(_ value: Array<Any>) throws {
        try value.enumerated().forEach({ (index, value) in
            switch value {
            case let value as Bool:
                try encode(value)
            case let value as Int:
                try encode(value)
            case let value as String:
                try encode(value)
            case let value as Double:
                try encode(value)
            case let value as CGFloat:
                try encode(value)
            case let value as Dictionary<String, Any>:
                try encode(value)
            case let value as Array<Any>:
                try encode(value)
            case Optional<Any>.none:
                try encodeNil()
            default:
                let keys = JSONCodingKeys(intValue: index).map({ [ $0 ] }) ?? []
                throw EncodingError.invalidValue(value, EncodingError.Context(codingPath: codingPath + keys, debugDescription: "Invalid JSON value"))
            }
        })
    }
    
    mutating func encode(_ value: Dictionary<String, Any>) throws {
        var nestedContainer = self.nestedContainer(keyedBy: JSONCodingKeys.self)
        try nestedContainer.encode(value)
    }
}



//public func decodeIfPresent(_ type: Bool.Type, forKey key: K) throws -> Bool?
//
//public func decodeIfPresent(_ type: String.Type, forKey key: K) throws -> String?
//
//public func decodeIfPresent(_ type: Double.Type, forKey key: K) throws -> Double?
//
//public func decodeIfPresent(_ type: Float.Type, forKey key: K) throws -> Float?
//
//public func decodeIfPresent(_ type: Int.Type, forKey key: K) throws -> Int?
//
//public func decodeIfPresent(_ type: Int8.Type, forKey key: K) throws -> Int8?
//
//public func decodeIfPresent(_ type: Int16.Type, forKey key: K) throws -> Int16?
//
//public func decodeIfPresent(_ type: Int32.Type, forKey key: K) throws -> Int32?
//
//public func decodeIfPresent(_ type: Int64.Type, forKey key: K) throws -> Int64?
//
//public func decodeIfPresent(_ type: UInt.Type, forKey key: K) throws -> UInt?
//
//public func decodeIfPresent(_ type: UInt8.Type, forKey key: K) throws -> UInt8?
//
//public func decodeIfPresent(_ type: UInt16.Type, forKey key: K) throws -> UInt16?
//
//public func decodeIfPresent(_ type: UInt32.Type, forKey key: K) throws -> UInt32?
//
//public func decodeIfPresent(_ type: UInt64.Type, forKey key: K) throws -> UInt64?
//
//public func decodeIfPresent<T>(_ type: T.Type, forKey key: K) throws -> T? where T : Decodable
