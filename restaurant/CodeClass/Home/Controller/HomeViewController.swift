//
//  HomeViewController.swift
//  restaurant
//
//  Created by 劉鉄男 on 2018/9/23.
//  Copyright © 2018年 劉鉄男. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift
import AlamofireImage

class HomeViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    @IBOutlet weak var oboButton: UIButton!
    @IBOutlet weak var oboNumbersLabel: UILabel!
    @IBOutlet weak var oboEndtimeLabel: UILabel!
    @IBOutlet weak var oboResultTimeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // Lottery情報APIを呼び出し
//        LotteryService.shared.getLottery(url: apiGetLotteries,
//           succeed: { (lotteryInfo) in
//           addLotterInfo(newOboInfo: lotteryInfo)
//        },
//           failed: { (message) in
//           dPrint(message)
//        })
//
//
//        // Lottery情報洗替
//        func addLotterInfo(newOboInfo: [OboInfo]) {
//
//            let realm = try! Realm()
//            let oldOboInfo = realm.objects(OboInfo.self)
//            try! realm.write {
//                realm.delete(oldOboInfo)
//                realm.add(newOboInfo)
//
//            }
//
//        }
//
//        let realm = try! Realm()
//        let oboInfo = realm.objects(OboInfo.self).first
//        let newLotterId = oboInfo?.lotteryId
//
//        let oboStatus = UserDefaults.standard.integer(forKey: "oboStatus")
//        let oboLotterId = UserDefaults.standard.string(forKey: "lotterId")
//
//        if oboStatus == 1 && oboLotterId == newLotterId {
//            self.oboButton.isEnabled = false
//            self.oboButton.setTitleColor(UIColor.gray, for: .normal)
//            self.oboButton.setTitle("応募ずみ", for: .normal)
//        }
        
        
        // 応募情報取得
        getLottery()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        // 応募情報取得
        getLottery()
    }
    
    
    @IBAction func oboOnClick(_ sender: Any) {
        
        
//        let realm = try! Realm()
//        let oboInfo = realm.objects(OboInfo.self).first
//        let lotterId:String = (oboInfo?.lotteryId)!
//
//        //応募する
//        let url = apiPostLotteries + lotterId
//        LotteryService.shared.postLottery(url: url,
//        succeed: { (message) in
//            print(message)
//           self.oboButton.isEnabled = false
//           self.oboButton.setTitleColor(UIColor.gray, for: .normal)
//           self.oboButton.setTitle("応募ずみ", for: .normal)
//
//           UserDefaults.standard.set(lotterId, forKey: "lotterId")
//           UserDefaults.standard.set(1, forKey: "oboStatus")
//
//        },
//
//         failed: { (message) in
//            print(message)
//            UtilClass.alertViewShowWithoutCancel(vc: UtilClass.AppCurrentViewController() ?? UIViewController(), title: message, sureHandler: nil)
//            UserDefaults.standard.set(lotterId, forKey: "lotterId")
//            UserDefaults.standard.set(0, forKey: "oboStatus")
//        })

        
    }
    
    
    
    func getLottery() {
        
        CommonService.shared.getLottery(
            url: apiGetLotteries,
            succeed: { (lottery) in
                self.addLottery(newLottery: lottery)
                self.showLottery()
        },
            failed: { (message) in
                let realm = try! Realm()
                if realm.objects(Lottery.self).isEmpty { // 最新施設情報取得失敗時にローカル施設情報が無い場合、下記アラートを画面に表示させる
                    UtilClass.alertViewShowWithoutCancel(vc: UtilClass.AppCurrentViewController() ?? UIViewController(), title: message, sureHandler: nil)
                }
        }
        )
    }

    func addLottery(newLottery: Lottery) {
        
        let realm = try! Realm()
        let oldLottery = realm.objects(Lottery.self)
        try! realm.write {
            realm.delete(oldLottery)
            realm.add(newLottery)
        }
    }
    
    func showLottery() {
        
        let realm = try! Realm()
        let nowLottery = realm.objects(Lottery.self).first

        
        itemNameLabel.text = nowLottery?.lotteryTitle
        itemPriceLabel.text = nowLottery?.lotteryDetail
        oboNumbersLabel.text = String((nowLottery?.count)!)
        oboEndtimeLabel.text = nowLottery?.endDatetime
        oboResultTimeLabel.text = nowLottery?.announcementDatetime
        
        let url: URL!
        url = URL(string: (nowLottery?.lotteryImageUrl)!)
        imageView.af_setImage(withURL: url!, placeholderImage: UIImage(named: "noImage")) // AlamofireImageにて自動的にキャッシュ管理をしてくれる
    }
    
    func apply(_ lotteryId:Int) {
        // APIを呼び出し
        LotteryService.shared.postLottery(url: apiPostLotteries + "/" + String(lotteryId),
                                          succeed: { (message) in
                                            dPrint(message)
                                            let title:String = "応募ありがとうございます！"
                                            let message:String=""
                                            UtilClass.alertViewShowWithoutCancel(vc: UtilClass.AppCurrentViewController() ?? UIViewController(), title: title,message: message, sureHandler: nil)
                                            
        },
                                          failed: { (message) in
                                            let title:String = "応募送信失敗しました！"
                                            let message:String="しばらくしてから再送信してください"
                                            UtilClass.alertViewShowWithoutCancel(vc: UtilClass.AppCurrentViewController() ?? UIViewController(), title: title,message: message, sureHandler: nil)
                                            dPrint(message)
                                            
        }
        )
    }
}
