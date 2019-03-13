//
//  ExtensionKit.swift
//  restaurant
//
//  Created by 劉鉄男 on 2018/9/23.
//  Copyright © 2018年 劉鉄男. All rights reserved.
//

import UIKit

extension Notification {
    struct UserInfoKey<ValueType>: Hashable {
        let key: String
    }
    
    func getUserInfo<T>(for key: Notification.UserInfoKey<T>) -> T {
        return userInfo![key] as! T
    }
}

extension Notification.Name {
    static let iPadStaffDidChangedNotification = Notification.Name(rawValue: "iPadStaffDidChangedNotification")
    static let reserveStatusDidChangedNotification = Notification.Name(rawValue: "reserveStatusDidChangedNotification")
    static let customerInfoDidModifiedNotification = Notification.Name(rawValue: "customerInfoDidModifiedNotification")
}

//extension Notification.UserInfoKey {
//    static var toDoStoreDidChangedChangeBehaviorKey: Notification.UserInfoKey<ToDoStore.ChangeBehavior> {
//        return Notification.UserInfoKey(key: "com.onevcat.app.ToDoStoreDidChangedNotification.ChangeBehavior")
//    }
//}

extension NotificationCenter {
    func post<T>(name aName: NSNotification.Name, object anObject: Any?, typedUserInfo aUserInfo: [Notification.UserInfoKey<T> : T]? = nil) {
        post(name: aName, object: anObject, userInfo: aUserInfo)
    }
}

extension Date {
    
    // MARK: Timestamp - 时间戳
    
    /// **timestamp** 时间戳字符串，纯数字组成
    static func dateFromTimestampString(timestamp: String) -> Date! {
        let time = Int(timestamp)!
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        return date
    }
    
    static func dateFromTimestamp(timestamp: Int) -> Date! {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        return date
    }
    
    static func dateJapanFromTimestamp(timestamp: Int) -> Date! {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        return japanDate(date: date)
    }
    
    static func currentLocalTimestamp() -> String! {
        let timezone = TimeZone.current
        
        return currentTimestamp(timezone: timezone)
    }
    
    static func japanDate(date: Date) -> Date! {
        let date = date
        let timezoneJP = TimeZone.init(identifier: "Asia/Tokyo")
        
        let formatter = DateFormatter.init()
        formatter.timeZone = timezoneJP
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateStr = formatter.string(from: date)
        
        let formatterJP = DateFormatter.init()
        formatterJP.timeZone = timezoneJP
        formatterJP.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateJP = formatterJP.date(from: dateStr)
        return dateJP
    }
    
    static func currentGreenwichTimestamp() -> String! {
        let timezone = TimeZone.init(identifier: "Europe/London")
        return currentTimestamp(timezone: timezone!)
    }
    
    static func currentTimestamp(timezone: TimeZone) -> String! {
        let date = Date()
        return timestamp(date: date, timezone: timezone)
    }
    
    static func timestamp(date: Date, timezone: TimeZone) -> String! {
        let interval = TimeInterval(timezone.secondsFromGMT(for: date))
        let localDate = date.addingTimeInterval(interval)
        let timestamp = String(Int(localDate.timeIntervalSince1970))
        return timestamp
    }
    
    static var currentDateStringWithoutTimeZoneString: String {
        return dateToString(date: Date(), dateFormat: "yyyy-MM-dd HH:mm:ss")
    }
    
    static func dayOClockLocalDate(date: Date) -> Date! {
        let calendar = Calendar.current
        guard let localODate = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: date) else { return Date() }
        return localODate
    }
    
    static func dayOClockJapanDate(day: Date) -> Date! { // 日期那天0点的系统时间的date
        let timezoneJP = TimeZone.init(identifier: "Asia/Tokyo")
        
        let formatter0 = DateFormatter()
        formatter0.timeZone = timezoneJP
        formatter0.dateFormat = "yyyy-MM-dd"
        let day0ClockStr = formatter0.string(from: day)
        
        let formatterJP = DateFormatter.init()
        formatterJP.timeZone = timezoneJP
        formatterJP.dateFormat = "yyyy-MM-dd"
        
        let dateJP = formatterJP.date(from: day0ClockStr)
        return dateJP
    }
    
    static func dayOClockJapanTimestamp(day: Date) -> Int! { // 日期那天0点的系统时间的时间戳
        //        let timezone = TimeZone.current
        //        let interval = TimeInterval(timezone.secondsFromGMT(for: day))
        //        let localDate = day.addingTimeInterval(interval)
        
        //        let calendar = Calendar.init(identifier: .japanese)
        //        guard let localODate = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: day) else { return 0 }
        
        let timezoneJP = TimeZone.init(identifier: "Asia/Tokyo")
        
        let formatter0 = DateFormatter()
        formatter0.timeZone = timezoneJP
        formatter0.dateFormat = "yyyy-MM-dd"
        let day0ClockStr = formatter0.string(from: day)
        
        let formatterJP = DateFormatter.init()
        formatterJP.timeZone = timezoneJP
        formatterJP.dateFormat = "yyyy-MM-dd"
        
        let dateJP = formatterJP.date(from: day0ClockStr)
        let timestamp = Int(dateJP!.timeIntervalSince1970)
        return timestamp
    }
    
    static func daysBetweenTwoDate(startDate: Date, endDate: Date) -> Int! {
        let calendar = Calendar.current
        let days = calendar.dateComponents([.day], from: startDate, to: endDate)
        return days.day!
    }
    
    static var todaysYMDDateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        //        formatter.locale = Locale.init(identifier: "Asia/Tokyo")
        formatter.timeZone = TimeZone.current
        let dateStr = formatter.string(from: Date())
        return dateStr
    }
    
    static func toLocalDate(date: Date) -> Date {
        let interval = TimeInterval(TimeZone.current.secondsFromGMT(for: date))
        let localDate = date.addingTimeInterval(interval)
        return localDate
    }
    
    static func dateToString(date: Date, dateFormat: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        let dateStr = formatter.string(from: date)
        return dateStr
        //        formatter.locale = Locale.init(identifier: "japanese") // NSLocale(localeIdentifier: NSCalendar.Identifier.japanese.rawValue) as Locale!
    }
    
//    func isToday() -> Bool{ // 判断日期是否是今天
//        let format = DateFormatter()
//        format.dateFormat = "yyyy-MM-dd"
//        return format.string(from: self) == format.string(from: Date())
//    }
    
    func isYestoday() -> Bool{ // 判断日期是否是昨天
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        return format.string(from: self) == format.string(from: Date().addingTimeInterval(-24 * 60 * 60))
    }
}

extension String {
    
    /// 国际化
    func localizeSelf() -> String {
        return localizedString(self)
    }
    
    func stringToInt() -> Int {
        if let i = Int(self) {
            return i
        } else {
            return 0
        }
    }
    
    func stringToFloat() -> Float {
        if let i = Float(self) {
            return i
        } else {
            return 0
        }
    }
    
    func stringToCGFloat() -> CGFloat {
        if let i = Float(self) {
            let j = CGFloat(i)
            return j
        } else {
            return 0
        }
    }
    
    /// 转成次世代的年月日
    func toYMDtype() -> String {
        if count >= 10 {
            return String(self.prefix(10))
        } else {
            return ""
        }
    }
    
    /// 转成次世代的年
    func toYType() -> String {
        if count >= 4 {
            return String(self.prefix(4))
        } else {
            return ""
        }
    }
    
    /// 转成次世代的月
    func toMType() -> String {
        if count >= 7 {
            let front = String(self.prefix(7))
            return String(front.suffix(2))
        } else {
            return ""
        }
    }
    
    /// 转成时分
    func toHHMMtype() -> String {
        if count > 4 {
            return String(self.suffix(5))
        } else {
            return ""
        }
    }
    
    /// 去空格
    func trimmingSpaceAndLine() -> String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    // MARK: - 进行URL编码
    func changeToURLEncoding() -> String {
        let characterSet = NSMutableCharacterSet.urlQueryAllowed
        //        characterSet.addCharacters(in: self)
        //        let str = self.stringByAddingPercentEncodingWithAllowedCharacters(characterSet)
        let str = self.addingPercentEncoding(withAllowedCharacters: characterSet as CharacterSet)
        return str!
    }
    
    /// MARK: - 从DateTimeOffset转成现在日期的String
    func toNowDateStrFromDateTimeOffset() -> String {
        let str1 = replacingOccurrences(of: "T", with: " ")
        let str2s = str1.components(separatedBy: [".", "+"])
        if str2s.count > 2 {
            let str3 = "\(str2s[0])+\(str2s[2])"
            
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateFormat = "yyyy-MM-dd HH:mm:ssZZZZ"
            let lastCameDateBefore = dateFormatter1.date(from: str3) ?? Date()
            
            let dateFormatter2 = DateFormatter()
            dateFormatter2.dateFormat = "yyyy-MM-dd HH:mm"
            return dateFormatter2.string(from: lastCameDateBefore)
        }
        return ""
    }
    
    // MARK: - 暂未处理
    func toLocalizableURLString() -> String {
        return self
    }
}

extension Int {
    func toPriceType() -> String {
        let formatter = NumberFormatter.init()
        formatter.numberStyle = .decimal
        let str = formatter.string(from: NSNumber.init(value: self))
        if str != nil {
            return str!
        }
        return ""
    }
    
    func intToFloat() -> Float {
        return Float(self)
    }
    
    func toCGFloat() -> CGFloat {
        return CGFloat(self)
    }
}

extension Float {
    // 带精度的小数
    func toPrecisionFloat(mode: NSDecimalNumber.RoundingMode, precision: Int16) -> Float {
        let decimalValue = NSDecimalNumber.init(value: self)
        let roundingStyle = NSDecimalNumberHandler.init(roundingMode: mode, scale: precision, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        return Float(truncating: decimalValue.rounding(accordingToBehavior: roundingStyle))
    }
    
    func toPrecisionString(mode: NSDecimalNumber.RoundingMode, precision: Int16) -> String {
        let decimalValue = NSDecimalNumber.init(value: self)
        let roundingStyle = NSDecimalNumberHandler.init(roundingMode: mode, scale: precision, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        return String(describing: decimalValue.rounding(accordingToBehavior: roundingStyle))
    }
    
    // 钱数带,的 比如1,300
    func toPriceType() -> String {
        let formatter = NumberFormatter.init()
        formatter.numberStyle = .decimal
        let str = formatter.string(from: NSNumber.init(value: self))
        if str != nil {
            return str!
        }
        return ""
    }
    
    func toCGFloat() -> CGFloat {
        return CGFloat(self)
    }
}

extension UIView{
    func setWane(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func setBorder(color: UIColor, width: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    func setFrameByCenter(rect: CGRect){
        self.bounds = CGRect.init(x: 0, y: 0, width: rect.width, height: rect.height)
        self.center.x = rect.origin.x
        self.center.y = rect.origin.y
    }
    
    var centerX: CGFloat{
        return self.originX + self.bounds.width/2
    }
    
    var centerY: CGFloat{
        return self.originY + self.bounds.height/2
    }
    
    var centerP: CGPoint{
        return CGPoint(x: self.centerX, y: self.centerY)
    }
    
    var endX: CGFloat{
        return self.frame.size.width + self.frame.origin.x
    }
    
    var endY: CGFloat{
        return self.frame.size.height + self.frame.origin.y
    }
    
    var originX: CGFloat {
        return self.frame.origin.x
    }
    
    var originY: CGFloat {
        return self.frame.origin.y
    }
    
    var frameWidth: CGFloat {
        return self.frame.width
    }
    
    var frameHeight: CGFloat {
        return self.frame.height
    }
    
    // MARK: - 添加个别角的圆角
    func addBoundingCorners(rectCorners: UIRectCorner, cornerRadii: CGSize) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: rectCorners, cornerRadii: cornerRadii)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    // MARK: - view 旋转
    func rotateToRight180Angle() {
        UIView.animate(withDuration: 0.3, animations: { [weak self] () -> Void in
            self?.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        })
    }
    
    func rotateToRight90Angle() {
        UIView.animate(withDuration: 0.3, animations: { [weak self] () -> Void in
            self?.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2))
        })
    }
    
    func restoreFromRotation() {
        UIView.animate(withDuration: 0.3, animations: { [weak self] () -> Void in
            self?.transform = CGAffineTransform(rotationAngle: CGFloat(0))
        })
    }
}


extension CALayer {
    @objc var borderUIColor: UIColor {
        set {
            self.borderColor = newValue.cgColor
        }
        
        get {
            return UIColor(cgColor: self.borderColor!)
        }
    }
    
    @objc var shadowUIColor: UIColor {
        set {
            self.shadowColor = newValue.cgColor
        }
        
        get {
            return UIColor(cgColor: self.borderColor!)
        }
    }
}

extension UIColor {
    class func colorWithHexCode(code : String) -> UIColor {
        let colorComponent = {(startIndex : Int ,length : Int) -> CGFloat in
            let indexStart = code.index(code.startIndex, offsetBy: startIndex)
            let indexEnd = code.index(indexStart, offsetBy: length - 1)
            var subHex = String(code[indexStart...indexEnd])
            // swift3
            //            var subHex = code.substring(with: Range<String.Index>.init(uncheckedBounds: (lower: code.index(code.startIndex, offsetBy: startIndex), upper: code.index(code.startIndex, offsetBy: startIndex + length))))
            // swift2
            //            var subHex = code.substringWithRange(Range<String.Index>(start: code.startIndex.advancedBy(startIndex), end: code.startIndex.advancedBy(startIndex + length)))
            subHex = subHex.count < 2 ? "\(subHex)\(subHex)" : subHex
            var component:UInt32 = 0
            Scanner(string: subHex).scanHexInt32(&component)
            return CGFloat(component) / 255.0}
        
        let argb = {() -> (CGFloat,CGFloat,CGFloat,CGFloat) in
            switch(code.count) {
            case 3: //#RGB
                let red = colorComponent(0,1)
                let green = colorComponent(1,1)
                let blue = colorComponent(2,1)
                return (red,green,blue,1.0)
            case 4: //#ARGB
                let alpha = colorComponent(0,1)
                let red = colorComponent(1,1)
                let green = colorComponent(2,1)
                let blue = colorComponent(3,1)
                return (red,green,blue,alpha)
            case 6: //#RRGGBB
                let red = colorComponent(0,2)
                let green = colorComponent(2,2)
                let blue = colorComponent(4,2)
                return (red,green,blue,1.0)
            case 8: //#AARRGGBB
                let alpha = colorComponent(0,2)
                let red = colorComponent(2,2)
                let green = colorComponent(4,2)
                let blue = colorComponent(6,2)
                return (red,green,blue,alpha)
            default:
                return (1.0,1.0,1.0,1.0)
            }}
        
        let color = argb()
        return UIColor(red: color.0, green: color.1, blue: color.2, alpha: color.3)
    }
}


extension NSObject {
    //MARK: 延时方法
    func delay(_ delay: Double, closure: @escaping ()->()) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
            closure()
        }
    }
}

