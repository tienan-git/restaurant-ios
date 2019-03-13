//
//  SwiftyJSON+Extension.swift
//  restaurant
//
//  Created by パク・セイミ on 2019/03/12.
//  Copyright © 2019 劉鉄男. All rights reserved.
//

import SwiftyJSON

extension JSON {
    var date: Date? {
        guard let value = self.double, value > 0 else {
            return nil
        }
        return Date(timeIntervalSince1970: value)
    }
}
