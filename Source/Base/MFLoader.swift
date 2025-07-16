/**
 * @file        MFLoader.swift
 * @brief     Define MFLoader cllass
 * @par Copyright
 *   Copyright (C) 2025 Steel Wheels Project
 */

import MultiDataKit
import JavaScriptCore
import Foundation

public class MFLoader
{
        public static func loadBootScript(context ctxt: MFContext) -> NSError? {
                guard let resdir = FileManager.default.resourceDirectory(forClass: MFLoader.self) else {
                        return MIError.error(errorCode: .fileError, message: "No resource directoryu", atFile: #file, function: #function)
                }

                let libfiles: Array<String> = [
                        "Frame.js"
                ]
                for file in libfiles {
                        let path = resdir.appendingPathComponent("Library/" + file)
                        NSLog("Load: \(path.path)")
                        if let err = ctxt.loadScript(from: path) {
                                return err
                        }
                }
                return nil
        }
}

