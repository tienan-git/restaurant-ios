//
//  NSObject+Extension.swift
//  restaurant
//
//  Created by パク・セイミ on 2019/03/12.
//  Copyright © 2019 劉鉄男. All rights reserved.
//

import UIKit

public extension NSObject {
//     func stringValue() ->String {
//        if self.isKindOfClass(NSNull) {
//            return ""
//        }
//        
//        if self.isKindOfClass(NSNumber) {
//            return (self as! NSNumber).stringValue()
//        }
//        
//        if self is String {
//            return self as! String
//        }
//        
//        return self.description
//    }
//    
     func numberValue() ->NSNumber {
        if self is NSNumber {
            return self as! NSNumber
        }
        
        if self is String {
            let f: NumberFormatter = NumberFormatter()
            f.numberStyle = .decimal
            let myNumber: NSNumber = f.number(from: self as! String)!
            return myNumber
        }
        
        return NSNumber.init(value: 0 as Int)
    }
    
     func intValue() ->Int {
        if self is Int {
            return self as!Int
        }
        
        if self is String {
            let f: NumberFormatter = NumberFormatter()
            f.numberStyle = .decimal
            let myNumber: NSNumber = f.number(from: self as! String)!
            return Int(truncating: myNumber)
        }
        return 0
    }
}
