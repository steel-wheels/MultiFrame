/**
 * @file        MINativeValue.swift
 * @brief     Extend MIValue data struture
 * @par Copyright
 *   Copyright (C) 2025 Steel Wheels Project
 */

import MultiDataKit
import Foundation
import JavaScriptCore

public extension MIValue
{
        static func fromObject(object obj: NSObject) -> MIValue {
                let result: MIValue
                if let _ = obj as? NSNull {
                        result = MIValue()
                } else if let numobj = obj as? NSNumber {
                        switch numobj.valueType {
                        case .nilType:
                                result = MIValue()
                        case .booleanType:
                                result = MIValue(booleanValue: numobj.boolValue)
                        case .unsignedIntType:
                                result = MIValue(unsignedIntValue: UInt(numobj.uint32Value))
                        case .signedIntType:
                                result = MIValue(signedIntValue: Int(numobj.int32Value))
                        case .floatType:
                                result = MIValue(floatValue: numobj.doubleValue)
                        case .stringType, .arrayType, .dictionaryType:
                                NSLog("[Error] Unexpected number type at \(#function)")
                                result = MIValue()
                        @unknown default:
                                NSLog("[Error] can not happen at \(#function)")
                                result = MIValue()
                        }
                } else if let strobj = obj as? NSString {
                        result = MIValue(stringValue: strobj as String)
                } else if let arrobj = obj as? NSArray {
                        result = MIValue.fromArrayObject(array: arrobj)
                } else if let dictobj = obj as? NSDictionary {
                        result = MIValue.fromDictionaryObject(dictionary: dictobj)
                } else {
                        NSLog("[Error] Unexpected object \(obj) at \(#function)")
                        result = MIValue()
                }
                return result
        }

        private static func fromArrayObject(array arr: NSArray) -> MIValue {
                var result: Array<MIValue> = []
                for elm in arr {
                        if let obj = elm as? NSObject {
                                result.append(MIValue.fromObject(object: obj))
                        } else {
                                NSLog("[Error] Unexpected object \(elm) at \(#function)")
                        }
                }
                return MIValue(arrayValue: result)
        }

        private static func fromDictionaryObject(dictionary dict: NSDictionary) -> MIValue {
                var result: Dictionary<String, MIValue> = [:]
                for (key, val) in dict {
                        if let keystr = key as? String {
                                if let valobj = val as? NSObject {
                                        result[keystr] = MIValue.fromObject(object: valobj)
                                } else {
                                        NSLog("[Error] Unexpected object \(val) at \(#function)")
                                }
                        } else {
                                NSLog("[Error] Unexpected object \(key) at \(#function)")
                        }
                }
                return MIValue(dictionaryValue: result)
        }
}
