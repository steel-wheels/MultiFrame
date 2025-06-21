/**
 * @file        MFConsole.swift
 * @brief      Define MFConsole class
 * @par Copyright
 *   Copyright (C) 2025 Steel Wheels Project
 */

import JavaScriptCore
import Foundation

@objc public protocol MFConsoleProtorol: JSExport
{
        func log(_ name: JSValue)
        func error(_ name: JSValue)
}

@objc public class MFConsole: NSObject, MFConsoleProtorol
{
        public static let VariableName = "console"

        public func log(_ name: JSValue) {
                if let str = name.toString() {
                        NSLog(str)
                } else {
                        NSLog("\(name)")
                }
        }
        
        public func error(_ name: JSValue)  {
                if let str = name.toString() {
                        NSLog(str)
                } else {
                        NSLog("[Error] \(name)")
                }
        }
}

