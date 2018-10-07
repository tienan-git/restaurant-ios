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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        // 応募情報取得
        getLottery()
    }
    
    @IBAction func oboOnClick(_ sender: Any) {
        
        let realm = try! Realm()
        let nowLottery = realm.objects(Lottery.self).first
        let lotteryId = nowLottery?.lotteryId
        apply(lotteryId!)
        
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
        
        if (nowLottery?.lotteryApplicationStatus != "0") {
            oboButton.isEnabled = false
            oboButton.setTitleColor(UIColor.gray, for: .normal)
            oboButton.setTitle(nowLottery?.lotteryApplicationStatusName, for: .normal)
        }else{
            oboButton.isEnabled = true
            oboButton.setTitleColor(UIColor.black, for: .normal)
            oboButton.setTitle("応募する", for: .normal)
        }
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
                                            self.getLottery()
                                            self.showLottery()
                                            let title:String = "応募ありがとうございます！"
                                            let message:String=""
                                            UtilClass.alertViewShowWithoutCancel(vc: UtilClass.AppCurrentViewController() ?? UIViewController(), title: title,message: message, sureHandler: nil)
                                            
        },
                                          failed: { (message) in
                                            let title:String = "応募失敗しました！"
                                            let message:String="しばらくしてから再度応募してください"
                                            UtilClass.alertViewShowWithoutCancel(vc: UtilClass.AppCurrentViewController() ?? UIViewController(), title: title,message: message, sureHandler: nil)
                                            dPrint(message)
                                            
        }
        )
    }
}
