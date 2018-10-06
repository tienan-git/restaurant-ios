//
//  LotteryHistory.swift
//  restaurant
//
//  Created by ソウ　リチョウ on 2018/10/07.
//  Copyright © 2018年 劉鉄男. All rights reserved.
//

import RealmSwift
import SwiftyJSON

class LotteryHistory: Object {
    
    @objc dynamic var lotteryTitle: String = ""
    @objc dynamic var lotteryDetail: String = ""
    @objc dynamic var lotteryStatus: String = ""
    @objc dynamic var applyDateTime: String = ""
    
    // JSONからObjectへ変換
    convenience init(_ json: JSON) {
        self.init()
        
        lotteryTitle = json["lotteryTitle"].stringValue
        lotteryDetail = json["lotteryDetail"].stringValue
        lotteryStatus = json["lotteryApplicationStatus"].stringValue
        applyDateTime = json["applyDatetime"].stringValue
    }
    
    // ObjectからDictionaryへ変換
    func convertIntoDictionary() -> Dictionary<String, Any> {
        let dic = [
            "lotteryTitle": lotteryTitle,
            "lotteryDetail": lotteryDetail,
            "lotteryApplicationStatus": lotteryStatus,
            "applyDatetime": applyDateTime
            ] as [String : Any]
        return dic
    }
    
}
