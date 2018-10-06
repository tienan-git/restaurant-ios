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
    }
    
    // MARK: - メソッド：View（施設情報画面）を表示させる
    internal func makeMyWindow(spotAnnotation: SpotAnnotation){
        UIApplication.shared.keyWindow?.addSubview(self)
        UIView.animate(withDuration: 0.20) {
            self.alpha = 1
        }
        spotNameLabel.text = spotAnnotation.restaurantName
        spotTypeLabel.text = "中華料理"
        
        
        let text1 = "住所：" + spotAnnotation.restaurantAddress!  + "\r\n"
        let text2 = "電話：" + spotAnnotation.restaurantAddress!  + "\r\n"
        let text3 = "営業時間：" + spotAnnotation.restaurantAddress!  + "\r\n"
        let text4 = "ホームページ：" + spotAnnotation.restaurantSiteUrl!
        let text = text1 + text2 + text3 + text4
        spotServiceLabel.text = text
        
        let url: URL!
        if spotAnnotation.restaurantImageUrl == nil {
            url = URL(fileURLWithPath: "noImage")
        } else {
            url = URL(string: spotAnnotation.restaurantImageUrl!)
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
