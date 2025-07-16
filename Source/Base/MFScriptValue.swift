/**
 * @file        MFScriptValue.swift
 * @brief     Extend JSValue data struture
 * @par Copyright
 *   Copyright (C) 2025 Steel Wheels Project
 */

import Foundation
import JavaScriptCore

public extension JSValue
{
        func toObject() -> NSObject {
                if self.isNull {
                        return NSNull()
                } else if self.isNumber {
                        return self.toNumber()
                } else if self.isString {
                        return self.toString() as NSString
                } else if self.isArray {
                        return self.toArray() as NSArray
                } else {
                        return self.toObject()
                }
        }

        static func fromObject(object obj: NSObject, context ctxt: MFContext) -> JSValue {
                if let _ = obj as? NSNull {
                        return JSValue(nullIn: ctxt)
                } else if let numobj = obj as? NSNumber {
                        return JSValue(object: numobj, in: ctxt)
                } else if let strobj = obj as? NSString {
                        return JSValue(object: strobj, in: ctxt)
                } else if let arrobj = obj as? NSArray {
                        return JSValue(object: arrobj, in: ctxt)
                } else if let dictobj = obj as? NSDictionary {
                        return JSValue(object: dictobj, in: ctxt)
                } else {
                        NSLog("[Error] Unknown object \(obj) at \(#function)")
                        return JSValue(object: obj, in: ctxt)
                }
        }
}

