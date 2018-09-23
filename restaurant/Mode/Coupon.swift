//
//  Bear.swift
//  restaurant
//
//  Created by 劉鉄男 on 2018/9/23.
//  Copyright © 2018年 劉鉄男. All rights reserved.
//

import RealmSwift
import SwiftyJSON

class Coupon: Object {
    
    @objc dynamic var couponId = ""
    @objc dynamic var couponName = ""
    @objc dynamic var couponDetail = ""
    @objc dynamic var couponPeriod = ""
    
    convenience init(json: JSON) {
        self.init()
        couponId = json["couponId"].stringValue
        couponName = json["couponName"].stringValue
        couponDetail = json["couponDetail"].stringValue
        couponPeriod = json["couponPeriod"].stringValue
    }
    
    func convertIntoDictionary() -> Dictionary<String, Any> {
        let dic = [
            "couponId": couponId,
            "couponName": couponName,
            "couponDetail": couponDetail,
            "couponPeriod": couponPeriod,
            ] as [String : Any]
        return dic
    }
}
