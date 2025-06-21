/**
 * @file        MFViewControllern.swift
 * @brief     Define MFViewControllern class
 * @par Copyright
 *   Copyright (C) 2025 Steel Wheels Project
 */

#if os(OSX)
import  AppKit
#else   // os(OSX)
import  UIKit
#endif  // os(OSX)
import MultiUIKit
import Foundation

open class MFViewController: MIViewController
{
        open override func viewDidLoad() {
                super.viewDidLoad()
                NSLog("view did load")
        }
}

