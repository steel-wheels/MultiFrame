//
//  ViewController.swift
//  UnitTest_macOS
//
//  Created by Tomoo Hamada on 2025/06/18.
//

import MultiFrameKit
import JavaScriptCore
import Cocoa

class ViewController: NSViewController {

        override func viewDidLoad() {
                super.viewDidLoad()

                // Do any additional setup after loading the view.
                let vm          = JSVirtualMachine()
                guard let context = JSContext(virtualMachine: vm) else {
                        NSLog("[Error] Failed to allocate context")
                        return
                }
                let application = MIApplication(context: context)
                application.boot(context: context)
        }

        override var representedObject: Any? {
                didSet {
                // Update the view, if already loaded.
                }
        }


}

