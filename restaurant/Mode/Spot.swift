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
    
    @objc dynamic var spotId: String = ""
    @objc dynamic var spotName: String = ""
    @objc dynamic var spotType: String = ""
    @objc dynamic var spotImageUrl: String = ""
    @objc dynamic var spotLatitude: String = ""
    @objc dynamic var spotLongitude: String = ""
    @objc dynamic var spotService1: Bool = false
    @objc dynamic var spotService2: Bool = false
    @objc dynamic var spotService3: Bool = false
    @objc dynamic var spotService4: Bool = false
    @objc dynamic var spotService5: Bool = false
    @objc dynamic var spotService6: Bool = false
    @objc dynamic var spotService7: Bool = false
    @objc dynamic var spotService8: Bool = false
    @objc dynamic var spotFlag: String = ""
    
    convenience init(json: JSON) {
        self.init()
        
        spotId = json["tour_spot_id"].stringValue
        spotName = json["name1"].stringValue
        spotType = json["spot_category_name"].stringValue
        spotImageUrl = json["spots_images_url"].stringValue
        spotLatitude = json["latitude"].stringValue
        spotLongitude = json["longitude"].stringValue
        spotService1 = json["チケット発行"].boolValue
        spotService2 = json["チケット利用"].boolValue
        spotService3 = json["LIQUID Pay 支払"].boolValue
        spotService4 = json["LIQUID マネーチャージ"].boolValue
        spotService5 = json["LIQUID ポイントチャージ"].boolValue
        spotService6 = json["パスポート込ユーザー登録"].boolValue
        spotService7 = json["既存ユーザーへの指紋登録"].boolValue
        spotService8 = json["ユーザー照会"].boolValue
        spotFlag = json["sp_flag"].stringValue
    }
    
    func convertIntoDictionary() -> Dictionary<String, Any> {
        let dic = [
            "tour_spot_id": spotId,
            "spotName": spotName,
            "spotType": spotType,
            "spotImageUrl": spotImageUrl,
            "spotLatitude": spotLatitude,
            "spotLongitude": spotLongitude,
            "spotService1": spotService1,
            "spotService2": spotService2,
            "spotService3": spotService3,
            "spotService4": spotService4,
            "spotService5": spotService5,
            "spotService6": spotService6,
            "spotService7": spotService7,
            "spotService8": spotService8,
            "spotFlag": spotFlag
            ] as [String : Any]
        return dic
    }
    
}
