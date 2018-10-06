//
//  Lottery.swift
//  restaurant
//
//  Created by 劉鉄男 on 2018/10/6.
//  Copyright © 2018年 劉鉄男. All rights reserved.
//

import RealmSwift
import SwiftyJSON

class Lottery: Object {
    
    @objc dynamic var lotteryId: Int = 0
    @objc dynamic var lotteryTitle: String = ""
    @objc dynamic var lotteryDetail: String = ""
    @objc dynamic var lotteryImageUrl: String = ""
    @objc dynamic var count: Int = 0
    @objc dynamic var lotteryApplicationStatus: String = ""
    @objc dynamic var lotteryApplicationStatusName: String = ""
    @objc dynamic var endDatetime: String = ""
    @objc dynamic var announcementDatetime: String = ""
    
    // JSONからObjectへ変換
    convenience init(_ json: JSON) {
        self.init()
        
        lotteryId = json["lotteryId"].intValue
        lotteryTitle = json["lotteryTitle"].stringValue
        lotteryDetail = json["lotteryDetail"].stringValue
        lotteryImageUrl = json["lotteryImageUrl"].stringValue
        count = json["count"].intValue
        lotteryApplicationStatus = json["lotteryApplicationStatus"].stringValue
        lotteryApplicationStatusName = json["lotteryApplicationStatusName"].stringValue
        endDatetime = json["endDatetime"].stringValue
        announcementDatetime = json["announcementDatetime"].stringValue
    }
    
    // ObjectからDictionaryへ変換
    func convertIntoDictionary() -> Dictionary<String, Any> {
        let dic = [
            "lotteryId": lotteryId,
            "lotteryTitle": lotteryTitle,
            "lotteryDetail": lotteryDetail,
            "lotteryImageUrl": lotteryImageUrl,
            "count": count,
            "lotteryApplicationStatus": lotteryApplicationStatus,
            "lotteryApplicationStatusName": lotteryApplicationStatusName,
            "endDatetime": endDatetime,
            "announcementDatetime": announcementDatetime
            ] as [String : Any]
        return dic
    }
    
}
