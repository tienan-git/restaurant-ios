//
//  URL+Extension.swift
//  restaurant
//
//  Created by パク・セイミ on 2019/03/12.
//  Copyright © 2019 劉鉄男. All rights reserved.
//

extension URL {
    var fragments : [String : String] {
        let components = URLComponents(string: absoluteString)
        var results: [String : String] = [:]
        guard let items = components?.queryItems else {
            return results
        }
        
        for item in items {
            results[item.name] = item.value
        }
        
        return results
    }
}
