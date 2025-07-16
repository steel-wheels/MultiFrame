/**
 * @file        MFRootView.swift
 * @brief      Define MFRootView class
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

public class MFRootView: MIStack, MFFrame
{
        static let FrameName            = "Button"

        private var mContext:   MFContext?   = nil
        private var mCore:      MFFrameCore? = nil

        public var frameName: String { get {
                return MFRootView.FrameName
        }}

        public var core: MFFrameCore { get {
                if let core = mCore {
                        return core
                } else {
                        fatalError("No core at \(#function)")
                }
        }}

        public func boot(instanceName iname: String, context ctxt: MFContext) {
                let core = MFFrameCore(frameName: MFRootView.FrameName, context: ctxt)
                ctxt.setObject(core.toScriptValue(), forKeyedSubscript: iname as NSString)
                mCore    = core
                mContext = ctxt
        }
}

