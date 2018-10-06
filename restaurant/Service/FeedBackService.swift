//
//  FeedBackService.swift
//  restaurant
//
//  Created by ソウ　リチョウ on 2018/10/06.
//  Copyright © 2018年 劉鉄男. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FeedBackService: NSObject {
    
    class var shared: FeedBackService {
        struct Singleton {
            static let instance = FeedBackService()
        }
        return Singleton.instance
    }
    

    // MARK: - メソッド：フィードバック
    func postFeedBack(url: String, feedbackDic: [String: Any], succeed: @escaping (String) -> Void, failed: @escaping (String) -> Void) {
        AlamofireInstance.requestNoHeader(method: .post, URLString: url, parameters: feedbackDic, encoding: JSONEncoding.default, completionHandler: {(response, result, data) in
            if response?.statusCode == 200 {
                let message = "フィードバック送信できました。"
                succeed(message)
            } else {
                let message = "フィードバック送信できません。"
                failed(message)
            }
        })
    }
}
