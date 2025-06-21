/**
 * @file        MIApplication.swift
 * @brief     Define MIApplication class
 * @par Copyright
 *   Copyright (C) 2025 Steel Wheels Project
 */

import MultiDataKit
import JavaScriptCore

public class MIApplication: MIFrame
{
        public static let  FrameName = "application"
        private static let CoreName  = "_application"

        private var mCore: MIFrameCore

        public var core: MIFrameCore { get { return mCore }}

        public init(context ctxt: MIScriptContext){
                mCore = MIFrameCore(frameName: MIApplication.FrameName, context: ctxt)
        }

        public func boot(context ctxt: MIScriptContext) -> Int {
                var errcount: Int = 0 ;

                NSLog("context: define application object")
                ctxt.setObject(mCore, forKeyedSubscript: MIApplication.CoreName as NSString)

                NSLog("context: define console object")
                let console = MIConsole()
                ctxt.setObject(console, forKeyedSubscript: MIConsole.VariableName as NSString)

                NSLog("context: import libraries")
                if let resdir = FileManager.default.resourceDirectory(forClass: MIApplication.self) {
                        let filenames: Array<String> = [
                                "Frame.js",
                                "Application.js"
                        ]
                        for filename in filenames {
                                NSLog("context: parse \(filename)")
                                errcount += ctxt.compileScript(resourceDirectory: resdir, fileName: filename)
                        }
                } else {
                        NSLog("[Error] Failed to get resource directory")
                        errcount += 1
                }

                NSLog("context: execute boot code")
                if let resdir = FileManager.default.resourceDirectory(forClass: MIApplication.self) {
                        let filenames: Array<String> = [
                                "Boot.js"
                        ]
                        for filename in filenames {
                                NSLog("context: parse \(filename)")
                                errcount += ctxt.compileScript(resourceDirectory: resdir, fileName: filename)
                        }
                } else {
                        NSLog("[Error] Failed to get resource directory")
                        errcount += 1
                }
                return errcount
        }
}

