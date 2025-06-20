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
                let vm  = JSVirtualMachine()
                let context     = MIScriptContext(virtualMachine: vm!)
                let application = MIApplication(context: context)
                let _ = application.boot(context: context)
        }

        override var representedObject: Any? {
                didSet {
                // Update the view, if already loaded.
                }
        }


}

