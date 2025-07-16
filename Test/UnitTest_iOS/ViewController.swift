//
//  ViewController.swift
//  UnitTest_iOS
//
//  Created by Tomoo Hamada on 2025/06/24.
//

import MultiUIKit
import MultiFrameKit
import UIKit
import JavaScriptCore

class ViewController: UIViewController
{

        @IBOutlet var mRootView: MFRootView!

        override func viewDidLoad() {
                super.viewDidLoad()
                NSLog("viewDidLoad")
                // Do any additional setup after loading the view.

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
                button0.boot(instanceName: "rootView", context: context)

                mRootView.addSubview(button0)
        }
}

