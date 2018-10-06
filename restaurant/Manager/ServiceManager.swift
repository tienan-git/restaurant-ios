//
//  ServiceManager.swift
//  restaurant
//
//  Created by 劉鉄男 on 2018/9/23.
//  Copyright © 2018年 劉鉄男. All rights reserved.
//

import UIKit
import Alamofire
import Alamofire_SwiftyJSON
import SwiftyJSON

let AlamofireInstance = ServiceManager.sharedInstance

class ServiceManager: NSObject {
    static let sharedInstance = ServiceManager()
    
    var response: ((DataResponse<Any>) -> Void)!
    
    // MARK: - リクエスト処理（ヘッダー無し）
    func requestNoHeader(method: HTTPMethod,
                         URLString: String,
                         parameters: [String: Any]? = nil,
                         encoding: ParameterEncoding,
                         headers: [String: String]? = nil,
                         completionHandler: @escaping (_ response: HTTPURLResponse?, _ result: Result<Any>, _ data: Data?) -> Void)
    {
        let urlStr = URLString.toLocalizableURLString()
        Alamofire.request(urlStr, method: method, parameters: parameters, encoding: encoding).responseJSON(completionHandler: { (response) in
            if response.result.error != nil {
                dPrint("response.result.error---\(response.result.error as Any)")
            }
            dPrint("parameters----------\(parameters as Any)")
            dPrint("response.response---\(response.response as Any)")
            dPrint("response.result-----\(response.result as Any)")
            dPrint("response.data-------\(response.data as Any)")
            completionHandler(response.response, response.result, response.data)
        })
    }
    
    // MARK: - リクエスト処理（ヘッダー付き）
    func requestBySwiftyJSON(method: HTTPMethod,
                             URLString: String,
                             parameters: [String: Any]? = nil,
                             encoding: ParameterEncoding,
                             completionHandler: @escaping (_ response: HTTPURLResponse?, _ data: JSON?) -> Void) {
        let urlStr = URLString.toLocalizableURLString()
        // 端末ID取得
        let deviceId = UIDevice.current.identifierForVendor!.uuidString
        let headers = ["From": deviceId]
        Alamofire.request(urlStr, method: method, parameters: parameters, encoding: encoding, headers: headers)
            .responseSwiftyJSON { dataResponse in
                dPrint("parameters---\(parameters as Any)")
                dPrint("headers---\(headers as Any)")
                
                if dataResponse.error != nil {
                    dPrint("dataResponse.error---\(dataResponse.error!)")
                }
                dPrint("dataResponse.request---\(dataResponse.request as Any)")
                dPrint("dataResponse.response---\(dataResponse.response as Any)")
                dPrint("dataResponse.value---\(dataResponse.value as Any)")
                if dataResponse.response?.statusCode == 0 {
                    
                } else if dataResponse.value == nil {
                    completionHandler(dataResponse.response, nil)
                } else {
                    completionHandler(dataResponse.response, dataResponse.value)
                }
        }
    }
    
    // MARK: - メソッド：ファイルアップロード
    func uploadFiles(data: [Data],
                     URLString: String,
                     completionHandler: @escaping (_ response: HTTPURLResponse?, _ data: JSON?) -> Void) {
        let urlStr = URLString.toLocalizableURLString()
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            data.forEach({ (data) in
                multipartFormData.append(data, withName: "files", fileName: "service.jpg", mimeType: "image/jpeg")
                dPrint("multipartFormData.contentType---\(multipartFormData.contentType)")
                dPrint("multipartFormData.contentLength---\(multipartFormData.contentLength)")
            })
        }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold, to: urlStr, headers: ["content-type": "multipart/form-data"]) { (multipartFormDataEncodingResult) in
            switch multipartFormDataEncodingResult {
            case .success(let upload, _, _):
                upload
                    .validate()
                    .responseSwiftyJSON(completionHandler: { (dataResponse) in
                        if dataResponse.error != nil {
                            dPrint("dataResponse.error---\(dataResponse.error!)")
                        }
                        dPrint("dataResponse.request---\(dataResponse.request as Any)")
                        dPrint("dataResponse.response---\(dataResponse.response as Any)")
                        dPrint("dataResponse.value---\(dataResponse.value as Any)")
                        if dataResponse.response?.statusCode == 0 {
                            
                        } else if dataResponse.value == nil {
                            completionHandler(dataResponse.response, nil)
                        } else {
                            completionHandler(dataResponse.response, dataResponse.value)
                        }
                    })
            case .failure(let encodingError):
                dPrint("encodingError: \(encodingError)")
            }
        }
    }
    
    // MARK: - メソッド：ファイルダウンロード
    func downLoadFile(URLString: String, completionHandler: @escaping (_ response: DefaultDownloadResponse?) -> Void) {
        
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent("file")
            
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        let urlStr = URLString.toLocalizableURLString()
        Alamofire.download(urlStr, to: destination).response { response in
            dPrint(response)
            
            if response.response?.statusCode == 0 {
                
            } else if response.error == nil, let _ = response.destinationURL?.path {
                completionHandler(response)
            }
        }
    }
}
