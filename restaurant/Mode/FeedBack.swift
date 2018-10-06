//
//  FeedBack.swift
//  restaurant
//
//  Created by ソウ　リチョウ on 2018/10/06.
//  Copyright © 2018年 劉鉄男. All rights reserved.
//

import RealmSwift
import SwiftyJSON

class FeedBack: Object {
    
    @objc dynamic var type = ""
    @objc dynamic var detail = ""
    
    convenience init(json: JSON) {
        self.init()
        type = json["type"].stringValue
        detail = json["detail"].stringValue
    }
    
    func convertIntoDictionary() -> Dictionary<String, Any> {
        let dic = [
            "type": type,
            "detail": detail,
            ] as [String : Any]
        return dic
    }
}
