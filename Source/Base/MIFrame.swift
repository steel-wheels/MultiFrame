/**
 * @file        MIFrameType.swift
 * @brief      Define data types for MIFrame class
 * @par Copyright
 *   Copyright (C) 2025 Steel Wheels Project
 */

import Foundation

public class MIFrame
{
        public var protocolFrame: MIFrame?  = nil
        public var parentFrame:   MIFrame?  = nil
        public var childrem: Array<MIFrame> = []
}

