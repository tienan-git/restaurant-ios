//
//  NavigationBarView.swift
//  restaurant
//
//  Created by パク・セイミ on 2019/03/14.
//  Copyright © 2019 劉鉄男. All rights reserved.
//
import UIKit

open class NavigationBarView: UIView {
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(){
        super.init(frame: CGRect.zero)
        self.frame = CGRect(x: 0, y: 0, width: kCommonDeviceWidth * 2, height: kCommonStatusBarHeight)
        self.clipsToBounds = false
    }
}
