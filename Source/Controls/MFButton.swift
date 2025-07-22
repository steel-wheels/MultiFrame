/**
 * @file        MFButton.swift
 * @brief      Define MFButton class
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

public class MFButton: MIButton, MFFrame
{
        static let FrameName            = "Button"
        static let TitlePropertyName    = "title"
        static let ClickedEventName     = "clicked"

        private var mCore:      MFFrameCore? = nil
        private var mContext:   MFContext?   = nil

        public var frameName: String { get {
                return MFButton.FrameName
        }}

        public var core: MFFrameCore { get {
                if let core = mCore {
                        return core
                } else {
                        fatalError("No core at \(#function)")
                }
        }}

        public func boot(instanceName iname: String, context ctxt: MFContext){
                let core = MFFrameCore(frameName: MFButton.FrameName, context: ctxt)

                /* add listner for title */
                core.addObserver(name: MFButton.TitlePropertyName, listner: {
                        (val: Any?) -> Void in
                        if let str = val as? NSString {
                                super.title = str as String
                        } else {
                                NSLog("[Error] Unexpected \(MFButton.TitlePropertyName) value in \(#file)")
                        }
                })

                /* set callback for the click */
                super.setCallback({
                        () -> Void in
                        NSLog("(\(#function) clicked")
                        if let obj = core.value(name: MFButton.ClickedEventName) as? JSValue {
                                NSLog("call clicked event of MFButton")
                                obj.call(withArguments: [])
                        }
                })

                ctxt.setObject(core.toScriptValue(), forKeyedSubscript: iname as NSString)
                mCore    = core
                mContext = ctxt
        }
}

