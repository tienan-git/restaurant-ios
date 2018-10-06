//
//  Spot.swift
//  restaurant
//
//  Created by 劉鉄男 on 2018/10/6.
//  Copyright © 2018年 劉鉄男. All rights reserved.
//

import RealmSwift
import SwiftyJSON

class Spot: Object {
    
    @objc dynamic var restaurantId: String = ""
    @objc dynamic var restaurantName: String = ""
    @objc dynamic var restaurantAddress: String = ""
    @objc dynamic var restaurantPhoneNumber: String = ""
    @objc dynamic var restaurantBusinessHours: String = ""
    @objc dynamic var restaurantSiteUrl: String = ""
    @objc dynamic var restaurantImageUrl: String = ""
    @objc dynamic var restaurantLatitude: Double = 0
    @objc dynamic var restaurantLongitude: Double = 0
    
    // JSONからObjectへ変換
    convenience init(json: JSON) {
        self.init()
        
        restaurantId = json["restaurantId"].stringValue
        restaurantName = json["restaurantName"].stringValue
        restaurantAddress = json["restaurantAddress"].stringValue
        restaurantPhoneNumber = json["restaurantPhoneNumber"].stringValue
        restaurantBusinessHours = json["restaurantBusinessHours"].stringValue
        restaurantSiteUrl = json["restaurantSiteUrl"].stringValue
        restaurantImageUrl = json["restaurantImageUrl"].stringValue
        restaurantLatitude = json["restaurantLatitude"].doubleValue
        restaurantLongitude = json["restaurantLongitude"].doubleValue
    }
    
    // ObjectからDictionaryへ変換
    func convertIntoDictionary() -> Dictionary<String, Any> {
        let dic = [
            "restaurantId": restaurantId,
            "restaurantName": restaurantName,
            "restaurantAddress": restaurantAddress,
            "restaurantPhoneNumber": restaurantPhoneNumber,
            "restaurantBusinessHours": restaurantBusinessHours,
            "restaurantSiteUrl": restaurantSiteUrl,
            "restaurantImageUrl": restaurantImageUrl,
            "restaurantLatitude": restaurantLatitude,
            "restaurantLongitude": restaurantLongitude
            ] as [String : Any]
        return dic
    }
    
}
