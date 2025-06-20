/**
 * @file        MIScriptContext.swift
 * @brief     JavaScript Context Manager
 * @par Copyright
 *   Copyright (C) 2025 Steel Wheels Project
 */

import MultiDataKit
import JavaScriptCore
import Foundation

public class MIScriptContext: JSContext
{
        public typealias ExceptionCallback =  (_ exception: MIScriptException) -> Void

        public  var exceptionCallback : ExceptionCallback
        private var mErrorCount        : Int

        public var errorCount: Int { get { return mErrorCount }}

        public override init(virtualMachine vm: JSVirtualMachine) {
                exceptionCallback = {
                        (_ exception: MIScriptException) -> Void in
                        NSLog("[Exception] \(exception.description)")
                }
                mErrorCount = 0
                super.init(virtualMachine: vm)

                /* Set handler */
                self.exceptionHandler = {
                        [weak self] (context, exception) in
                        if let myself = self, let ctxt = context as? MIScriptContext {
                                let except = MIScriptException(context: ctxt, value: exception)
                                myself.exceptionCallback(except)
                                myself.mErrorCount += 1
                        } else {
                                NSLog("[Error] Unexpected context at \(#function)")
                        }
                }
        }

        public func compileScript(resourceDirectory resdir: URL, fileName fname: String) -> Int {
                let resfile = resdir.appending(path: "Library/" + fname)
                let prevcnt = self.errorCount ;
                switch loadScript(from: resfile) {
                case .success(let script):
                        self.evaluateScript(script)
                case .failure(let error):
                        NSLog("[Error] " + MIError.errorToString(error: error))
                        mErrorCount += 1
                }
                return self.errorCount - prevcnt
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

public class MIScriptException
{
        private var mContext    : MIScriptContext
        private var mValue      : JSValue?

        public init(context ctxt: MIScriptContext, value val: JSValue?) {
                mContext         = ctxt
                mValue                = val
        }

        public init(context ctxt: MIScriptContext, message msg: String) {
                mContext        = ctxt
                mValue          = JSValue(object: msg, in: ctxt)
        }

        public var description: String { get {
                if let val = mValue {
                        return val.toString()
                } else {
                        return "nil"
                }
        }}
}
