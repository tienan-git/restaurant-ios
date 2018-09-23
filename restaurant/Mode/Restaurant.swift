//
//  Spot.swift
//  restaurant
//
//  Created by 劉鉄男 on 2018/9/23.
//  Copyright © 2018年 劉鉄男. All rights reserved.
//

import RealmSwift
import SwiftyJSON

class Restaurant: Object {
    
    @objc dynamic var restaurantId: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var address: String = ""
    @objc dynamic var phoneNumber: String = ""
    @objc dynamic var imageUrl: String = ""
    @objc dynamic var latitude: String = ""
    @objc dynamic var longitude: String = ""
    @objc dynamic var couponExistflag: String = ""
    @objc dynamic var couponId: String = ""
    @objc dynamic var couponName: String = ""
    @objc dynamic var couponDetail: String = ""
    @objc dynamic var couponPeriod: String = ""
    
    convenience init(json: JSON) {
        self.init()
        restaurantId = json["restaurantId"].stringValue
        name = json["name"].stringValue
        address = json["address"].stringValue
        phoneNumber = json["phoneNumber"].stringValue
        imageUrl = json["imageUrl"].stringValue
        latitude = json["latitude"].stringValue
        longitude = json["longitude"].stringValue
        couponExistflag = json["couponExistflag"].stringValue
        couponId = json["couponId"].stringValue
        couponName = json["couponName"].stringValue
        couponDetail = json["couponDetail"].stringValue
        couponPeriod = json["couponPeriod"].stringValue
    }
    
    func convertIntoDictionary() -> Dictionary<String, Any> {
        let dic = [
            "restaurantId": restaurantId,
            "name": name,
            "address": address,
            "phoneNumber": phoneNumber,
            "imageUrl": imageUrl,
            "latitude": latitude,
            "longitude": longitude,
            "couponExistflag": couponExistflag,
            "couponId": couponId,
            "couponName": couponName,
            "couponDetail": couponDetail,
            "couponPeriod": couponPeriod,
        ] as [String : Any]
        return dic
    }
    
}
