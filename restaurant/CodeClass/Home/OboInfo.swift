//
//  OboInfo.swift
//  restaurant
//
//  Created by パク・セイミ on 2018/10/06.
//  Copyright © 2018年 劉鉄男. All rights reserved.
//

import RealmSwift
import SwiftyJSON

class OboInfo: Object {
    
    @objc dynamic var lotteryId:String = ""
    @objc dynamic var lotteryTitle = ""
    @objc dynamic var lotteryDetail = ""
    @objc dynamic var lotteryImageUrl = ""
    @objc dynamic var count = 0
    @objc dynamic var lotteryApplicationStatus = ""
    @objc dynamic var lotteryApplicationStatusName = ""
    @objc dynamic var endDatetime = ""
    @objc dynamic var announcementDatetime = ""
    
    
    // JSONからObjectへ変換
    convenience init(json: JSON) {
        self.init()
        
        lotteryId = json["lotteryId"].stringValue
        lotteryTitle = json["lotteryTitle"].stringValue
        lotteryDetail = json["lotteryDetail"].stringValue
        lotteryImageUrl = json["lotteryImageUrl"].stringValue
        count = json["count"].intValue
        lotteryApplicationStatus = json["lotteryApplicationStatus"].stringValue
        lotteryApplicationStatusName = json["lotteryApplicationStatusName"].stringValue
        endDatetime = json["endDatetime"].stringValue
        announcementDatetime = json["announcementDatetime"].stringValue
    }

}
