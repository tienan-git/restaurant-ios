//
//  ApiClient.swift
//  restaurant
//
//  Created by パク・セイミ on 2019/03/12.
//  Copyright © 2019 劉鉄男. All rights reserved.
//

open class ApiClient: BaseApiClient {
    override open class func baseURL() ->String? {
//        #if DEBUG
        return "http://api.restaurant.sparkworks.jp/api/"
//        #elseif STAGING
//        return "http://api.restaurant.sparkworks.jp/api"
//        #else
//        return "http://api.restaurant.sparkworks.jp/api"
//        #endif
    }
    
//    override open class func apiKey() ->String? {
//        return "98c63d8f9214a4dafdb4d75e180b88619441281c52a4ffc086fca252f5b2b811"
//    }
}
