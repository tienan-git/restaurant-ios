//
//  UtilClass.swift
//  restaurant
//
//  Created by 劉鉄男 on 2018/9/23.
//  Copyright © 2018年 劉鉄男. All rights reserved.
//

import UIKit
import SVProgressHUD

// MARK: - 国际化字符串方法
func localizedString(_ string: String) -> String {
    return NSLocalizedString(string, comment: "")
}

// MARK: - SVProgressHUD
let svMaskType = SVProgressHUDMaskType.clear
let svFont = UIFont.systemFont(ofSize: 20)
let svNotiTime: TimeInterval = 30
let svAlertTime: TimeInterval = 20
let svToastTime: TimeInterval = 3
let isHudCanTouchDismiss = "isHudCanTouchDismiss"

// MARK: - release的时候不编译的方法
func dPrint(_ item: @autoclosure () -> Any) {
    #if DEBUG
    print(item())
    #endif
}

// MARK: - 配列内をランダムにシャッフルする
extension Array {
    
    mutating func shuffle() {
        for i in 0..<self.count {
            let j = Int(arc4random_uniform(UInt32(self.indices.last!)))
            if i != j {
                self.swapAt(i, j)
            }
        }
    }
    
    var shuffled: Array {
        var copied = Array<Element>(self)
        copied.shuffle()
        return copied
    }
}

class UtilClass: NSObject {
    // MARK: - base64加密
    class func stringToBase64(string: String) -> String {
        // Create NSData object
        let data = string.data(using: .utf8)
        
        // Get NSString from NSData object in Base64
        let base64Encoded = data?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
        
        // Print the Base64 encoded string
        dPrint(base64Encoded as Any)
        
        return base64Encoded!
    }
    
    // MARK: - base64解密
    class func base64ToString(string: String) -> String {
        // NSData from the Base64 encoded str
        let base64Data = Data.init(base64Encoded: string, options: Data.Base64DecodingOptions.init(rawValue: 0))
        
        // Decoded NSString from the NSData
        let base64Decode = String.init(data: base64Data!, encoding: String.Encoding.utf8)
        dPrint(base64Decode as Any)
        
        return base64Decode!
    }
    
    // MARK: - 根据已知长宽比得出在该手机屏幕上显示的高度
    class func heightOnThisIphone(height: CGFloat? = 0, width: CGFloat? = 0, heightWidthScale: CGFloat? = 0) -> CGFloat {
        if height != 0 && width != 0 {
            return kScreenWidth * height! / width!
        }
        return kScreenWidth * heightWidthScale!
    }
    
    // MARK: - 自适应高度
    class func heightAdaptationWithStr(str: String, width: CGFloat, fontFloat: CGFloat) -> CGFloat {
        let dic = NSDictionary.init(object: UIFont.systemFont(ofSize: fontFloat), forKey: NSAttributedString.Key.font as NSCopying)
        let bounds: CGRect = str.boundingRect(with: CGSize(width: width, height: 0), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key : Any], context: nil)
        return bounds.size.height
    }
    
    // MARK: - 自适应宽度
    class func widthAdaptationWithStr(str: String, height: CGFloat, fontFloat: CGFloat) -> CGFloat {
        let dic = NSDictionary.init(object: UIFont.systemFont(ofSize: fontFloat), forKey: NSAttributedString.Key.font as NSCopying)
        let bounds: CGRect = str.boundingRect(with: CGSize(width: 0, height: height), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key : Any], context: nil)
        return bounds.size.width
    }
    
    // MARK: - 除法加上后面几位小数的条件
    class func convertScaleWithFloat(mode: NSDecimalNumber.RoundingMode, num: Float, scale: Int16) -> NSDecimalNumber {
        let decimalValue = NSDecimalNumber.init(value: num)
        let roundingStyle = NSDecimalNumberHandler.init(roundingMode: mode, scale: scale, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        return decimalValue.rounding(accordingToBehavior: roundingStyle)
    }
    
    class func convertScaleWithDouble(mode: NSDecimalNumber.RoundingMode, num: Double, scale: Int16) -> NSDecimalNumber {
        let decimalValue = NSDecimalNumber.init(value: num)
        let roundingStyle = NSDecimalNumberHandler.init(roundingMode: mode, scale: scale, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        return decimalValue.rounding(accordingToBehavior: roundingStyle)
    }
    
    // MARK: - 返回带不同颜色的多属性字符串 如果字体大小不需要改变那么count给0
    class func convertStringToAttributedStringRequireArraySameCount(strs: [String], colors: [UIColor], count: Int, font: UIFont?) -> NSMutableAttributedString {
        if strs.count == colors.count && strs.count != 0 {
            let attributedString = NSMutableAttributedString.init()
            for i in 0 ..< strs.count {
                let attriStr = NSMutableAttributedString(string: strs[i])
                attriStr.addAttributes([NSAttributedString.Key.foregroundColor : colors[i]], range: NSRange.init(location: 0, length: strs[i].count))
                attributedString.append(attriStr)
            }
            
            if count > attributedString.length {
                return attributedString
            }
            
            if font != nil {
                attributedString.addAttributes([NSAttributedString.Key.font: font!], range: NSRange.init(location: 0, length: attributedString.length - count))
                attributedString.addAttributes([NSAttributedString.Key.font: UIFont.init(name: font!.fontName, size: font!.pointSize / 2)!], range: NSRange.init(location: attributedString.length - count, length: count))
            }
            
            return attributedString
        }
        return NSMutableAttributedString.init()
    }
    
    // MARK: - return顶层ViewController（不如说是最底层）
    class func AppNowPresentViewController() -> UIViewController? {
        var presentVC = UIApplication.shared.keyWindow?.rootViewController
        while presentVC?.presentedViewController != nil {
            presentVC = presentVC?.presentedViewController
        }
        return presentVC
    }
    
    // MARK: - 与上面的很多时候表示的都是tabBarController，有时候会是pop出的VC
    class func AppTopViewController() -> UIViewController? {
        var topVC = UIViewController()
        var keyWindow = UIApplication.shared.keyWindow
        if keyWindow?.windowLevel != UIWindow.Level.normal {
            let windows = UIApplication.shared.windows
            for window in windows {
                if window.windowLevel == UIWindow.Level.normal {
                    keyWindow = window
                    break
                }
            }
        }
        
        let frontView = keyWindow?.subviews.first
        let nextResponder = frontView?.next
        
        if (nextResponder?.isKind(of: UIViewController.self))! {
            if let topVc = nextResponder as? UIViewController {
                return topVc
            }
        } else {
            topVC = (keyWindow?.rootViewController)!
        }
        
        return topVC
    }
    
    // MARK: - return当前显示的ViewController
    class func AppCurrentViewController() -> UIViewController? {
        let keyWindow = UIApplication.shared.keyWindow
        var currentVC = keyWindow?.rootViewController
        while true {
            if (currentVC?.isKind(of: UITabBarController.self))! {
                currentVC = (currentVC as! UITabBarController).selectedViewController
            }
            if (currentVC?.isKind(of: UINavigationController.self))! {
                currentVC = (currentVC as! UINavigationController).visibleViewController
            }
            if ((currentVC?.presentedViewController) != nil) {
                currentVC = currentVC?.presentedViewController
            } else {
                break
            }
        }
        
        return currentVC
    }
    
    // MARK: - 正则判断数字
    class func arabicNumeralJudge(string: String) -> Bool {
        let anRegex = "^[0-9]*$"
        let anTest = NSPredicate.init(format: "SELF MATCHES%@", anRegex)
        if anTest.evaluate(with: string) == true {
            return true
        } else {
            return false
        }
    }
    
    // MARK: - alertView
    class func alertViewShow(vc: UIViewController, title: String, cancelCompletion: (() -> Void)?, sureHandler: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController.init(title: title, message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction.init(title: "キャンセル", style: .cancel, handler: { (action) -> Void in
            cancelCompletion?()
            alertController.dismiss(animated: true, completion: nil)
        })
        let sureAction = UIAlertAction.init(title: "確定", style: .default, handler: sureHandler)
        alertController.addAction(cancelAction)
        alertController.addAction(sureAction)
        vc.present(alertController, animated: true, completion: nil)
    }
    
    class func alertViewShowWithoutCancel(vc: UIViewController, title: String, sureHandler: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController.init(title: title, message: nil, preferredStyle: .alert)
        let sureAction = UIAlertAction.init(title: "確定", style: .default, handler: sureHandler)
        alertController.addAction(sureAction)
        vc.present(alertController, animated: true, completion: nil)
    }
    
    /// タイトル&本文
    class func alertViewShowWithoutCancel(vc: UIViewController, title: String, message: String, sureHandler: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let sureAction = UIAlertAction.init(title: "確定", style: .default, handler: sureHandler)
        alertController.addAction(sureAction)
        vc.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - SVProgressHUD
    /// 转圈的
    class func svHUDShow(maskType: SVProgressHUDMaskType) {
        UserDefaults.standard.set(false, forKey: isHudCanTouchDismiss)
        UserDefaults.standard.synchronize()
        
        SVProgressHUD.setDefaultMaskType(maskType)
        SVProgressHUD.show()
    }
    
    /// 带图片的
    class func svHUDShowWithImage(maskType: SVProgressHUDMaskType, font: UIFont, time: TimeInterval, image: UIImage, string: String) {
        UserDefaults.standard.set(true, forKey: isHudCanTouchDismiss)
        UserDefaults.standard.synchronize()
        
        SVProgressHUD.setDefaultMaskType(maskType)
        SVProgressHUD.setFont(font)
        SVProgressHUD.setMinimumDismissTimeInterval(time)
        SVProgressHUD.show(image, status: string)
    }
    
    /// 对号
    class func svHUDShowSuccess(maskType: SVProgressHUDMaskType, font: UIFont, time: TimeInterval, string: String) {
        UserDefaults.standard.set(true, forKey: isHudCanTouchDismiss)
        UserDefaults.standard.synchronize()
        
        SVProgressHUD.setDefaultMaskType(maskType)
        SVProgressHUD.setFont(font)
        SVProgressHUD.setMinimumDismissTimeInterval(time)
        SVProgressHUD.showSuccess(withStatus: string)
    }
    
    /// 叉叉
    class func svHUDShowError(maskType: SVProgressHUDMaskType, font: UIFont, time: TimeInterval, string: String) {
        UserDefaults.standard.set(true, forKey: isHudCanTouchDismiss)
        UserDefaults.standard.synchronize()
        
        SVProgressHUD.setDefaultMaskType(maskType)
        SVProgressHUD.setFont(font)
        SVProgressHUD.setMinimumDismissTimeInterval(time)
        SVProgressHUD.showError(withStatus: string)
    }
    
    /// 感叹号
    class func svHUDShowInfo(maskType: SVProgressHUDMaskType, font: UIFont, time: TimeInterval, string: String) {
        UserDefaults.standard.set(true, forKey: isHudCanTouchDismiss)
        UserDefaults.standard.synchronize()
        
        SVProgressHUD.setDefaultMaskType(maskType)
        SVProgressHUD.setFont(font)
        SVProgressHUD.setMinimumDismissTimeInterval(time)
        SVProgressHUD.showInfo(withStatus: string)
    }
    
    /// 只有字
    class func svHUDShow(maskType: SVProgressHUDMaskType, font: UIFont, time: TimeInterval, string: String) {
        UserDefaults.standard.set(true, forKey: isHudCanTouchDismiss)
        UserDefaults.standard.synchronize()
        
        SVProgressHUD.setDefaultMaskType(maskType)
        SVProgressHUD.setFont(font)
        SVProgressHUD.setMinimumDismissTimeInterval(time)
        SVProgressHUD.show(withStatus: string)
    }
    
    /// 取消
    class func svHUDDismiss() {
        SVProgressHUD.dismiss()
    }
    
    // 指定範囲で乱数を取得する
    class func arc4random(lower: UInt32, upper: UInt32) -> UInt32 {
        guard upper >= lower else {
            return 0
        }
        return arc4random_uniform(upper - lower) + lower
    }
    
    // 秒数から00:00形式へ変更する
    class func getTimeFromSeconds(seconds:TimeInterval)->String{
        if seconds.isNaN{
            return "00:00"
        }
        var Min = Int(seconds / 60)
        let Sec = Int(seconds.truncatingRemainder(dividingBy: 60))
        var Hour = 0
        if Min>=60 {
            Hour = Int(Min / 60)
            Min = Min - Hour*60
            return String(format: "%02d:%02d:%02d", Hour, Min, Sec)
        }
        return String(format: "%02d:%02d", Min, Sec)
    }
    
    // DateからStringへ変換
    class func dateFromString(string: String, format: String) -> Date {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: string)! as Date
    }
    
    // StringからDateへ変換
    class func stringFromDate(date: Date, format: String) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}
