//
//  AppDelegate.swift
//  UnitTest_macOS
//
//  Created by Tomoo Hamada on 2025/06/18.
//

import MultiFrameKit
import JavaScriptCore
import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate
{
        private var mApplication: MFApplication? = nil


        func applicationDidFinishLaunching(_ aNotification: Notification) {
                if mApplication == nil {
                        let vm          = JSVirtualMachine()
                        let context     = MFScriptContext(virtualMachine: vm!)
                        let application = MFApplication(context: context)
                        let _ = application.boot(context: context)
                        mApplication = application
                }
                // Insert code here to initialize your application
        }

        func applicationWillTerminate(_ aNotification: Notification) {
                // Insert code here to tear down your application
        }

        func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
                return true
        }


}

