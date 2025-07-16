//
//  ViewController.swift
//  UnitTest_macOS
//
//  Created by Tomoo Hamada on 2025/06/18.
//

import MultiFrameKit
import MultiUIKit
import JavaScriptCore
import Cocoa

class ViewController: MIViewController
{

        @IBOutlet var mRootView: MFRootView!

        override func viewDidLoad() {
                super.viewDidLoad()

                // Do any additional setup after loading the view.
                let context: JSContext
                let vm      = JSVirtualMachine()
                if let ctxt = JSContext(virtualMachine: vm) {
                        context = ctxt
                } else {
                        NSLog("[Error] Failed to allocate context")
                        return
                }

                mRootView.boot(instanceName: "rootView", context: context)

                let button0 = MFButton()
                button0.boot(instanceName: "button0", context: context)

                mRootView.addSubview(button0)

        }

        override var representedObject: Any? {
                didSet {
                // Update the view, if already loaded.
                }
        }


}

