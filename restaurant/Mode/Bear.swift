//
//  Bear.swift
//  restaurant
//
//  Created by 劉鉄男 on 2018/9/23.
//  Copyright © 2018年 劉鉄男. All rights reserved.
//

import Foundation
import RealmSwift

class Bear: Object {
    
    @objc dynamic var bearImageName = ""
    @objc dynamic var catchTime = ""
    @objc dynamic var catchPlace = ""
    @objc dynamic var status = ""
    
    convenience init(bearImageName: String, catchTime: String, catchPlace: String, status: String) {
        self.init()
        self.bearImageName = bearImageName
        self.catchTime = catchTime
        self.catchPlace = catchPlace
        self.status = status
    }
    
    func convertIntoDictionary() -> Dictionary<String, Any> {
        var yutaponType = ""
        switch self.bearImageName {
        case "ゆたぽん（レッド）":
            yutaponType = "red"
        case "ゆたぽん（ピンク）":
            yutaponType = "pink"
        case "ゆたぽん（イエロー）":
            yutaponType = "yellow"
        case "ゆたぽん（グリーン）":
            yutaponType = "green"
        case "ゆたぽん（ブルー）":
            yutaponType = "blue"
        default:
            yutaponType = ""
        }
        let dic = [
            "yutaponType": yutaponType,
            "spotName": self.catchPlace,
            "dateTime": self.catchTime,
            "status": self.status
            ] as [String : Any]
        return dic
    }
}
