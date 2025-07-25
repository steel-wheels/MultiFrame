/**
 * @file        MFStack.swift
 * @brief      Define MFStack class
 * @par Copyright
 *   Copyright (C) 2025 Steel Wheels Project
 */

import MultiUIKit
import JavaScriptCore
#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)

public class MFStack: MIStack, MFFrame
{
        static let FrameName = "Box"

        private var mContext:   MFContext?   = nil
        private var mCore:      MFFrameCore? = nil

        public var frameName: String { get {
                return MFStack.FrameName
        }}
        
        public var core: MFFrameCore { get {
                if let core = mCore {
                        return core
                } else {
                        fatalError("No core at \(#function)")
                }
        }}

        public func boot(instanceName iname: String, context ctxt: MFContext) {
                let core = MFFrameCore(frameName: MFStack.FrameName, context: ctxt)
                ctxt.setObject(core.toScriptValue(), forKeyedSubscript: iname as NSString)
                mCore    = core
                mContext = ctxt
        }
}

