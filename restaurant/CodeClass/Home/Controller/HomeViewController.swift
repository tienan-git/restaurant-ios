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
        
        // Lottery情報APIを呼び出し
        LotteryService.shared.getLottery(url: apiGetLotteries,
           succeed: { (lotteryInfo) in
           addLotterInfo(newOboInfo: lotteryInfo)
        },
           failed: { (message) in
           dPrint(message)
        })
        
        
        // Lottery情報洗替
        func addLotterInfo(newOboInfo: [OboInfo]) {
            
            let realm = try! Realm()
            let oldOboInfo = realm.objects(OboInfo.self)
            try! realm.write {
                realm.delete(oldOboInfo)
                realm.add(newOboInfo)
                
            }
            
        }
        
        let realm = try! Realm()
        let oboInfo = realm.objects(OboInfo.self).first
        let newLotterId = oboInfo?.lotteryId
        
        let oboStatus = UserDefaults.standard.integer(forKey: "oboStatus")
        let oboLotterId = UserDefaults.standard.string(forKey: "lotterId")
        
        if oboStatus == 1 && oboLotterId == newLotterId {
            self.oboButton.isEnabled = false
            self.oboButton.setTitleColor(UIColor.gray, for: .normal)
            self.oboButton.setTitle("応募ずみ", for: .normal)
        }
        
        
    }
    
    
    @IBAction func oboOnClick(_ sender: Any) {
        
        
        let realm = try! Realm()
        let oboInfo = realm.objects(OboInfo.self).first
        let lotterId:String = (oboInfo?.lotteryId)!

        //応募する
        let url = apiPostLotteries + lotterId
        LotteryService.shared.postLottery(url: url,
        succeed: { (message) in
            print(message)
           self.oboButton.isEnabled = false
           self.oboButton.setTitleColor(UIColor.gray, for: .normal)
           self.oboButton.setTitle("応募ずみ", for: .normal)
        
           UserDefaults.standard.set(lotterId, forKey: "lotterId")
           UserDefaults.standard.set(1, forKey: "oboStatus")
            
        },
        
         failed: { (message) in
            print(message)
            UtilClass.alertViewShowWithoutCancel(vc: UtilClass.AppCurrentViewController() ?? UIViewController(), title: message, sureHandler: nil)
            UserDefaults.standard.set(lotterId, forKey: "lotterId")
            UserDefaults.standard.set(0, forKey: "oboStatus")
        })

        
    }
    
    
    
    
    
    



}
