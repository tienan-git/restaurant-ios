//
//  LotteryService.swift
//  restaurant
//
//  Created by ソウ　リチョウ on 2018/10/06.
//  Copyright © 2018年 劉鉄男. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LotteryService: NSObject {
    
    class var shared: LotteryService {
        struct Singleton {
            static let instance = LotteryService()
        }
        return Singleton.instance
    }
    
    // MARK: - メソッド：抽選情報取得
    func getLottery(url: String, succeed: @escaping ([OboInfo]) -> Void, failed: @escaping (String) -> Void) {
        URLCache.shared.removeAllCachedResponses()
        AlamofireInstance.requestBySwiftyJSON(method: .get, URLString: url, encoding: JSONEncoding.default, completionHandler: {(response, data) in
            if response?.statusCode == 200 {
                dPrint("data------------\(data)")
                let json = data!["lottery"].arrayValue
                dPrint("dataJSON------------\(json)")
                let oboInfo = json.map(OboInfo.init)
                succeed(oboInfo)
            } else {
                let message = "店情報は取得できません。"
                failed(message)
            }
        })
    }
    
    // MARK: - メソッド：応募情報同期
    func postLottery(url: String, succeed: @escaping (String) -> Void, failed: @escaping (String) -> Void) {
        AlamofireInstance.requestNoHeader(method: .post, URLString: url, encoding: JSONEncoding.default, completionHandler: {(response, result, data) in
            if response?.statusCode == 200 {
                let message = "応募情報が同期できました。"
                succeed(message)
            } else {
                let message = "応募情報が同期できません。"
                failed(message)
            }
        })
    }
    
}

