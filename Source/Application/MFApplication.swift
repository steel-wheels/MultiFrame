/**
 * @file        MFApplication.swift
 * @brief     Define MFApplication class
 * @par Copyright
 *   Copyright (C) 2025 Steel Wheels Project
 */

import MultiDataKit
import JavaScriptCore

public class MFApplication: MFFrame
{
        public static let  FrameName = "application"
        private static let CoreName  = "_application"

        private var mCore: MFFrameCore

        public var core: MFFrameCore { get { return mCore }}

        public init(context ctxt: MFScriptContext){
                mCore = MFFrameCore(frameName: MFApplication.FrameName, context: ctxt)
        }

        public func boot(context ctxt: MFScriptContext) -> Int {
                var errcount: Int = 0 ;

                NSLog("context: define application object")
                ctxt.setObject(mCore, forKeyedSubscript: MFApplication.CoreName as NSString)

                NSLog("context: define console object")
                let console = MFConsole()
                ctxt.setObject(console, forKeyedSubscript: MFConsole.VariableName as NSString)

                NSLog("context: import libraries")
                if let resdir = FileManager.default.resourceDirectory(forClass: MFApplication.self) {
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
                if let resdir = FileManager.default.resourceDirectory(forClass: MFApplication.self) {
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

