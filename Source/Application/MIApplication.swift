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

        public init(context ctxt: JSContext){
                mCore = MIFrameCore(frameName: MIApplication.FrameName, context: ctxt)
        }

        public func boot(context ctxt: JSContext){
                NSLog("boot: define application object")
                ctxt.setObject(mCore, forKeyedSubscript: MIApplication.CoreName as NSString)

                if let resdir = FileManager.default.resourceDirectory(forClass: MIApplication.self) {
                        let filenames: Array<String> = [
                                "Frame.js",
                                "Application.js"
                        ]
                        for filename in filenames {
                                let resfile = resdir.appending(path: "Library/" + filename)
                                switch loadScript(from: resfile) {
                                case .success(let script):
                                        NSLog("loaded: \(script)")
                                case .failure(let error):
                                        NSLog("[Error] " + MIError.errorToString(error: error))
                                }
                        }
                } else {
                        NSLog("[Error] Failed to get resource directory")
                }
        }
        private func loadScript(from url: URL) -> Result<String, NSError> {
                do {
                        let text = try String(contentsOf: url, encoding: .utf8)
                        return .success(text)
                } catch {
                        return .failure(MIError.error(errorCode: .fileError,
                                                      message: "Failed to load from URL \(url.path)"))
                }
        }
}

