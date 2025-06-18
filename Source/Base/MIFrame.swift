/**
 * @file        MIFrame.swift
 * @brief      Define data types for the Frame
 * @par Copyright
 *   Copyright (C) 2025 Steel Wheels Project
 */

import MultiDataKit
import Foundation
import JavaScriptCore

@objc public protocol MIFrameCoreProtorol: JSExport
{
        func _value(_ name: JSValue) -> JSValue
        func _setValue(_ name: JSValue, _ val: JSValue) -> JSValue              // -> boolean
        func _addObserver(_ property: JSValue, _ cbfunc: JSValue) -> JSValue    // -> boolean
}

public protocol MIFrame
{
        var core: MIFrameCore { get }
}

public extension MIFrame
{
        typealias ListenerFunction = MIObserverDictionary.ListenerFunction

        func value(name nm: String) -> MIValue? {
                return self.core.value(name: nm)
        }

        func setValue(name nm: String, value val: MIValue) {
                self.core.setValue(name: nm, value: val)
        }

        func addObserver(name nm: String, listner lfunc: @escaping ListenerFunction){
                self.core.addObserver(name: nm, listner: lfunc)
        }
}

public class MIFrameCore: NSObject, MIFrameCoreProtorol
{
        public typealias ListenerFunction = MIObserverDictionary.ListenerFunction
        public typealias ListnerHolder    = MIObserverDictionary.ListnerHolder

        private var mFrameName:         String
        private var mProperties:        MIObserverDictionary
        private var mChildren:          Array<MIFrame>
        private var mListnerHolders:    Array<ListnerHolder>
        private var mContext:           JSContext

        public var parent:              MIFrame?
        public var children: Array<MIFrame> { get {
                return mChildren
        }}

        public init(frameName fname: String, context ctxt: JSContext) {
                mFrameName      = fname
                mProperties     = MIObserverDictionary()
                mChildren       = []
                mListnerHolders = []
                mContext        = ctxt
                parent          = nil
        }

        deinit {
                for listner in mListnerHolders {
                        mProperties.removeObserver(listnerHolder: listner)
                }
        }

        public func value(name nm: String) -> MIValue? {
                if let obj = mProperties.value(forKey: nm) {
                        return MIValue.fromObject(object: obj)
                } else {
                        return nil
                }
        }

        public func _value(_ name: JSValue) -> JSValue {
                guard let nmstr = _name(name: name) else {
                        return JSValue(nullIn: mContext)
                }
                if let nval  = value(name: nmstr) {
                        return JSValue(object: nval.toObject(), in: mContext)
                } else {
                        return JSValue(nullIn: mContext)
                }
        }

        public func setValue(name nm: String, value val: MIValue) {
                mProperties.setValue(val.toObject(), forKey: nm)
        }

        public func _setValue(_ name: JSValue, _ val: JSValue) -> JSValue {
                guard let nmstr = _name(name: name) else {
                        return JSValue(bool: false, in: mContext)
                }
                mProperties.setValue(val.toObject(), forKey: nmstr)
                return JSValue(bool: true, in: mContext)
        }

        public func addObserver(name nm: String, listner lfunc: @escaping ListenerFunction){
                let holder = mProperties.addObserver(forKey: nm, listnerFunction: lfunc)
                mListnerHolders.append(holder)
        }

        public func _addObserver(_ property: JSValue, _ cbfunc: JSValue) -> JSValue {
                guard let propstr = _name(name: property) else {
                        return JSValue(bool: false, in: mContext)
                }
                addObserver(name: propstr, listner: {
                        (_ : Any?) -> Void in
                        if let selfval = JSValue(object: self, in: self.mContext) {
                                cbfunc.call(withArguments: [selfval])
                        } else {
                                NSLog("[Error] Failed to add observer at \(#function)")
                        }
                })
                return JSValue(bool: true, in: mContext)
        }

        private func _name(name nm: JSValue) -> String? {
                if let str = nm.toString() {
                        return str ;
                } else {
                        NSLog("[Error] The name parameter must be string at \(#function)")
                        return nil
                }
        }
}

/*
 /**
  * @file        ALFrameCore.swift
  * @brief        Define ALFrameCore class
  * @par Copyright
  *   Copyright (C) 2022 Steel Wheels Project
  */

 import CoconutData
 import KiwiEngine
 import KiwiLibrary

 import Foundation


 @objc public class ALFrameCore: NSObject, ALFrameCoreProtorol
 {
         public static let FrameNameItem                = "frameName"
         public static let PropertyNamesItem        = "propertyNames"



         private var mFrameName:                String
         private var mPropertyTypes:        Dictionary<String, CNValueType>        // <property-name, value-type>
         private var mPropertyNames:        Array<String>
         private var mPropertyValues:        CNObserverDictionary

         private var mContext:                KEContext

         public var owner:                 AnyObject?

         public init(frameName cname: String, context ctxt: KEContext){
                 mFrameName                = cname
                 mPropertyTypes                = [:]
                 mPropertyNames                = []
                 mPropertyValues                = CNObserverDictionary()
                 mPropertyListners        = []
                 mContext                = ctxt
                 owner                        = nil
         }

         public var context: KEContext { get {
                 return mContext
         }}

         public var frameName: String { get {
                 return mFrameName
         }}

         public var propertyNames: Array<String> { get {
                 return mPropertyNames
         }}

         public func propertyType(propertyName pname: String) -> CNValueType? {
                 return mPropertyTypes[pname]
         }

         public func _value(_ name: JSValue) -> JSValue {
                 if let namestr = name.toString() {
                         if let val = value(name: namestr) {
                                 return val
                         }
                 }
                 return JSValue(nullIn: mContext)
         }

         public func _setValue(_ name: JSValue, _ val: JSValue) -> JSValue {
                 let result: Bool
                 /* Add property name if it is not defined */
                 if let namestr = name.toString() {
                         setValue(name: namestr, value: val)
                         result = true
                 } else {
                         result = false
                 }
                 return JSValue(bool: result, in: mContext)
         }

         public func value(name nm: String) -> JSValue? {
                 if let val = mPropertyValues.value(forKey: nm) as? JSValue {
                         return val
                 } else {
                         return nil
                 }
         }

         public func setValue(name nm: String, value val: JSValue) {
                 addPropertyName(name: nm)
                 mPropertyValues.setValue(val, forKey: nm)
         }

         public func _definePropertyType(_ property: JSValue, _ type: JSValue) {
                 if let pname = property.toString(), let tcode = type.toString() {
                         definePropertyType(propertyName: pname, typeCode: tcode)
                 } else {
                         CNLog(logLevel: .error, message: "Invalid \"property\" or \"type\" parameter for define property method")
                 }
         }

         public func definePropertyType(propertyName pname: String, typeCode tcode: String) {
                 switch CNValueType.decode(code: tcode) {
                 case .success(let vtype):
                         definePropertyType(propertyName: pname, valueType: vtype)
                 case .failure(let err):
                         CNLog(logLevel: .error, message: err.toString())
                 }
         }

         public func definePropertyTypes(propertyTypes ptypes: Dictionary<String, CNValueType>) {
                 for (name, type) in ptypes {
                         definePropertyType(propertyName: name, valueType: type)
                 }
         }

         public func definePropertyType(propertyName nm: String, valueType vtype: CNValueType) {
                 addPropertyName(name: nm)
                 mPropertyTypes[nm] = vtype
         }

         private func addPropertyName(name nm: String) {
                 if let _ = mPropertyNames.firstIndex(where: { $0 == nm }) {
                         /* Already defined */
                 } else {
                         mPropertyNames.append(nm)
                 }
         }

         public func _addObserver(_ property: JSValue, _ cbfunc: JSValue) {
                 if let pname = property.toString() {
                         addPropertyObserver(propertyName: pname,  listnerFunction: {
                                 (_ param: Any?) -> Void in cbfunc.call(withArguments: [])
                         })
                 } else {
                         CNLog(logLevel: .error, message: "Invalid \"property\" parameter for _addObserver method")
                 }
         }

         public func addPropertyObserver(propertyName pname: String, listnerFunction lfunc: @escaping CNObserverDictionary.ListenerFunction) {
                 mPropertyListners.append(
                         mPropertyValues.addObserver(forKey: pname, listnerFunction: lfunc)
                 )
         }
 }

 */
