/**
 * @file        MFDropView.swift
 * @brief      Define MFDropView class
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

public class MFDropView: MIDropView, MFFrame
{
        static let FrameName            = "Button"

        private var mCore:      MFFrameCore? = nil
        private var mContext:   MFContext?   = nil

        public var frameName: String { get {
                return MFDropView.FrameName
        }}

        public var core: MFFrameCore { get {
                if let core = mCore {
                        return core
                } else {
                        fatalError("No core at \(#function)")
                }
        }}

        public func boot(instanceName iname: String, context ctxt: MFContext) {
                mContext = ctxt
        }
}

