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
                let vm   = JSVirtualMachine()
                let ctxt = MFContext(virtualMachine: vm)

                if let err = MFLoader.loadBootScript(context: ctxt) {
                        NSLog("[Error] \(MIError.toString(error: err))")
                }

                let button0 = MFButton()
                mRootView.addSubview(button0)

                mRootView.boot(instanceName: "rootView", context: ctxt)
                button0.boot(instanceName: "button0", context: ctxt)
        }

        override var representedObject: Any? {
                didSet {
                // Update the view, if already loaded.
                }
        }


}

