//
//  Const.swift
//  restaurant
//
//  Created by パク・セイミ on 2019/03/12.
//  Copyright © 2019 劉鉄男. All rights reserved.
//

import UIKit

//
public let kCommonDeviceWidth = UIScreen.main.bounds.size.width
public let kCommonDeviceHeight = UIScreen.main.bounds.size.height
public let kCommonStatusBarHeight = UIApplication.shared.statusBarFrame.size.height
// よく使うカラーとか、よく使う定数をここにまとめている
public let kBackGroundColor: UIColor = UIColor.colorWithHex(0xECEDED)
public let kBorderColor: UIColor = UIColor.colorWithHex(0xE0E0E0)
let deviceId = UIDevice.current.identifierForVendor!.uuidString
