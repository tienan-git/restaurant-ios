//
//  SpotVIew.swift
//  restaurant
//
//  Created by 劉鉄男 on 2018/9/23.
//  Copyright © 2018年 劉鉄男. All rights reserved.
//

import UIKit
import AlamofireImage

protocol SpotViewDelegate: class {
    func routeGuideOrOnlyForClose()
    func useCoupon()
}

class SpotView: UIView {
    
    @IBOutlet weak var spotTapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet weak var spotNameLabel: UILabel!
    @IBOutlet weak var spotCloseUpButton: UIButton!
    @IBOutlet weak var spotImageView: UIImageView!
    @IBOutlet weak var spotTypeLabel: UILabel!
    @IBOutlet weak var spotServiceLabel: UILabel!
    @IBOutlet weak var spotRouteGuideButton: UIButton!
    
    weak var delegate: SpotViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.frame = UIScreen.main.bounds
        self.alpha = 0
        self.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    
    // MARK: - イベント：全画面の任意部分（該当Viewのボタン以外）をタップする時
    @IBAction func closeUpByGesture(_ sender: UITapGestureRecognizer) {
        dismiss()
    }
    
    // MARK: - イベント：「×」ボタンをタップする時
    @IBAction func closeUpByButton(_ sender: UIButton) {
        dismiss()
    }
    
    // MARK: - イベント：地図の場合「経路案内」ボタン、ARの場合「閉じる」ボタンをタップする時
    @IBAction func routeGuideOrOnlyForClose(_ sender: UIButton) {
        dismiss()
        if delegate is MapViewController {
            delegate?.routeGuideOrOnlyForClose()
        }
        if delegate is CouponViewController {
            delegate?.useCoupon()
        }
    }
    
    // MARK: - メソッド：View（施設情報画面）を表示させる
    internal func makeMyWindow(spotName: String?, spotType: String?, spotServiceArray: [Bool]?, spotImageUrl: String?){
        UIApplication.shared.keyWindow?.addSubview(self)
        UIView.animate(withDuration: 0.20) {
            self.alpha = 1
        }
        
        if spotName == "NULL" || spotName == "null" || spotName == ""{
            spotNameLabel.text = ""
        } else {
            spotNameLabel.text = spotName
        }
        
        if spotType == "NULL" || spotType == "null" || spotName == ""{
            spotTypeLabel.text = "その他施設"
        } else {
            spotTypeLabel.text = spotType
        }
        
        var text = "「利用可能サービス」"
        if (spotServiceArray?.count)! > 0 {
            for i in 0...(spotServiceArray?.count)! - 1 {
                if spotServiceArray![i] {
                    text = text + "\r\n" + spotServiceNameArray[i]
                }
            }
        }
        spotServiceLabel.text = text
        
        let url: URL!
        if spotImageUrl == "NULL" || spotImageUrl == "null" || spotImageUrl == ""{
            url = URL(fileURLWithPath: "noImage")
        } else {
            url = URL(string: spotImageUrl!)
        }
        spotImageView.af_setImage(withURL: url!, placeholderImage: UIImage(named: "noImage")) // AlamofireImageにて自動的にキャッシュ管理をしてくれる
    }
    
    // MARK: - メソッド：View（施設情報画面）を消えさせる
    func dismiss() {
        UIView.animate(withDuration: 0.35, animations: {
            self.alpha = 0
        }) { (bool) in
            self.removeFromSuperview()
        }
    }
}

