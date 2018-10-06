//
//  CommonService.swift
//  restaurant
//
//  Created by 劉鉄男 on 2018/9/23.
//  Copyright © 2018年 劉鉄男. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CommonService: NSObject {
    
    class var shared: CommonService {
        struct Singleton {
            static let instance = CommonService()
        }
        return Singleton.instance
    }
    
    // MARK: - メソッド：施設情報取得
    func getSpots(url: String, headers: [String: String]?, succeed: @escaping ([Spot]) -> Void, failed: @escaping (String) -> Void) {
        URLCache.shared.removeAllCachedResponses()
        AlamofireInstance.requestBySwiftyJSON(method: .get, URLString: url, encoding: JSONEncoding.default, headers: headers, completionHandler: {(response, data) in
            if response?.statusCode == 200 {
                dPrint("data------------\(data)")
                let json = data!["data"].arrayValue
                dPrint("dataJSON------------\(json)")
                let spots = json.map(Spot.init)
                succeed(spots)
            } else {
                let message = "店情報は取得できません。"
                failed(message)
            }
        })
    }
    
    // MARK: - メソッド：ゆたぽん情報同期
    func postYutapons(url: String, yutaponDic: [String: Any], succeed: @escaping (String) -> Void, failed: @escaping (String) -> Void) {
        AlamofireInstance.requestNoHeader(method: .post, URLString: url, parameters: yutaponDic, encoding: JSONEncoding.default, completionHandler: {(response, result, data) in
            if response?.statusCode == 200 {
                let message = "ゆたぽん情報が同期できました。"
                succeed(message)
            } else {
                let message = "ゆたぽん情報が同期できません。"
                failed(message)
            }
        })
    }
    
}

