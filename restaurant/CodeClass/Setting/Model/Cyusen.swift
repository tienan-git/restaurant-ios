//
//  Cyusen.swift
//  restaurant
//
//  Created by パク・セイミ on 2018/10/02.
//  Copyright © 2018年 劉鉄男. All rights reserved.
//

import Foundation
import RealmSwift

class Cyusen: Object {
    
    @objc dynamic var cyusenDate = ""
    @objc dynamic var cyusenItem = ""
    @objc dynamic var cyusenResult = ""
    
    convenience init(cyusenDate: String, cyusenItem: String, cyusenResult: String) {
        self.init()
        self.cyusenDate = cyusenDate
        self.cyusenItem = cyusenItem
        self.cyusenResult = cyusenResult
    }
}
