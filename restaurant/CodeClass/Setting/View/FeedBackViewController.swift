//
//  FeedBackViewController.swift
//  restaurant
//
//  Created by パク・セイミ on 2018/09/23.
//  Copyright © 2018年 劉鉄男. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

class FeedBackViewController: UIViewController {
    
    @IBOutlet weak var feedbackTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedbackTextView.text = ""
        feedbackTextView.layer.borderWidth = 1
        //是否可以滚动
        feedbackTextView.isScrollEnabled = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButtonClicked(_ sender:Any){
        
        postFeedBack()
    }
    
    // フィードバック
    func postFeedBack() {
        
        if feedbackTextView.text == "" {
            let title:String = "本文をご記入ください"
            let message:String=""
            UtilClass.alertViewShowWithoutCancel(vc: UtilClass.AppCurrentViewController() ?? UIViewController(), title: title,message: message, sureHandler: nil)
            return
        }
        
        
        
        // フィードバック情報取得
        var feedBack:FeedBack = FeedBack()
        feedBack.type = "01"// TODO 一旦固定
        feedBack.detail = feedbackTextView.text
        
        // APIを呼び出し
        FeedBackService.shared.postFeedBack(url: apiPostFeedbacks, feedbackDic: feedBack.convertIntoDictionary(),
                                            succeed: { (message) in
                                                dPrint(message)
                                                let title:String = "フィードバックありがとうございます！"
                                                let message:String=""
                                                UtilClass.alertViewShowWithoutCancel(vc: UtilClass.AppCurrentViewController() ?? UIViewController(), title: title,message: message, sureHandler: nil)
                                                
        },
                                            failed: { (message) in
                                                let title:String = "フィードバック送信失敗しました！"
                                                let message:String="しばらくしてから再送信してください"
                                                UtilClass.alertViewShowWithoutCancel(vc: UtilClass.AppCurrentViewController() ?? UIViewController(), title: title,message: message, sureHandler: nil)
                                                dPrint(message)
                                                
        }
        )
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
