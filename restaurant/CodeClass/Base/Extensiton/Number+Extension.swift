//
//  Int+Extension.swift
//  restaurant
//
//  Created by パク・セイミ on 2019/03/12.
//  Copyright © 2019 劉鉄男. All rights reserved.
//

import UIKit

public extension Int {
    
    public func string() ->String {
        return String(self)
    }
    
    public func double() ->Double {
        return Double(self)
    }
    
    public func thousandsSeparator() ->String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        formatter.groupingSize = 3
        let result = formatter.string(from: NSNumber(integerLiteral: self))
        return result!
    }
    
    public func cgfloat() ->CGFloat {
        return CGFloat(self)
    }
}

public extension Double {
    public func date() ->NSDate {
        return NSDate(timeIntervalSince1970: self)
    }
    
    public func int() ->Int {
        return Int(self)
    }
    
    public func cgfloat() ->CGFloat {
        return CGFloat(self)
    }
}

public extension CGFloat {
    public func int() ->Int{
        return Int(self)
    }
}

