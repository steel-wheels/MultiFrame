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

        @IBOutlet var mRootView: MFStack!

        override func viewDidLoad() {
                super.viewDidLoad()
                NSLog("viewDidLoad")
                // Do any additional setup after loading the view.

                // Do any additional setup after loading the view.
                let vm   = JSVirtualMachine()
                let ctxt = MFContext(virtualMachine: vm)
                
                let button0 = MFButton()
                mRootView.addSubview(button0)

                mRootView.boot(instanceName: "rootView", context: ctxt)
                button0.boot(instanceName: "button0", context: ctxt)
        }
}

