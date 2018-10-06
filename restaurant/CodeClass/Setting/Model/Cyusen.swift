//
//  Cyusen.swift
//  restaurant
//
//  Created by パク・セイミ on 2018/10/02.
//  Copyright © 2018年 劉鉄男. All rights reserved.
//

import RealmSwift
import SwiftyJSON

class Cyusen: Object {
    
    @objc dynamic var lotteryTitle: String = ""
    @objc dynamic var lotteryDetail: String = ""
    @objc dynamic var lotteryStatus: String = ""
    @objc dynamic var applyDateTime: String = ""
    
    // JSONからObjectへ変換
    convenience init(json: JSON) {
        self.init()
        
        lotteryTitle = json["lotteryTitle"].stringValue
        lotteryDetail = json["lotteryDetail"].stringValue
        lotteryStatus = json["lotteryStatus"].stringValue
        applyDateTime = json["applyDateTime"].stringValue
    }
    
    // ObjectからDictionaryへ変換
    func convertIntoDictionary() -> Dictionary<String, Any> {
        let dic = [
            "lotteryTitle": lotteryTitle,
            "lotteryDetail": lotteryDetail,
            "lotteryStatus": lotteryStatus,
            "applyDateTime": applyDateTime
            ] as [String : Any]
        return dic
    }
}
