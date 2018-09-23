//
//  BearReleaseView.swift
//  restaurant
//
//  Created by 劉鉄男 on 2018/9/23.
//  Copyright © 2018年 劉鉄男. All rights reserved.
//

import UIKit
import RealmSwift

protocol BearReleaseViewDelegate: class {
    func passOnInformation(letAllGoButtonFlag: Bool)
}

class BearReleaseView: UIView {
    
    @IBOutlet weak var bearViewGesture: UITapGestureRecognizer!
    @IBOutlet weak var bearView: UIView!
    @IBOutlet weak var bearViewImage: UIImageView!
    @IBOutlet weak var bearViewLabel: UILabel!
    @IBOutlet weak var letItGoButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    weak var delegate: BearReleaseViewDelegate?
    
    var targetName = ""
    var letAllGoButtonFlag = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
    }
    
    // MARK: - イベント：全画面の任意部分（該当Viewのボタン以外）をタップする時
    @IBAction func dismiss(_ sender: UITapGestureRecognizer) {
        dismiss()
    }
    
    // MARK: - イベント：「×」ボタンをタップする時
    @IBAction func close(_ sender: UIButton) {
        dismiss()
    }
    
    // MARK: - イベント：「逃がす」「全て逃がす」ボタンをタップする時
    @IBAction func letItGo(_ sender: UIButton) {
        let realm = try! Realm()
        if targetName == "ゆたぽん（ファイブ）" {
            // 全てゆたぽんを削除する
            let bears = realm.objects(Coupon.self).filter("status == '0'")
            try! realm.write {
                bears.setValue("1", forKey: "status")
            }
            letAllGoButtonFlag = true
        } else {
            // 該当ゆたぽんを削除する
            if let result = realm.objects(Coupon.self).filter("bearImageName = %@ AND status == '0'", targetName).first {
                try! realm.write {
                    result.status = "1"
                }
            }
        }
        delegate?.passOnInformation(letAllGoButtonFlag: letAllGoButtonFlag)
        self.removeFromSuperview()
    }
    
    // MARK: - メソッド：View（ゆたぽん逃がす画面）を表示させる
    internal func makeMyWindow(name: String, text: String){
        UIApplication.shared.keyWindow?.addSubview(self)
        UIView.animate(withDuration: 0.35) {
            self.alpha = 1
        }
        
        bearView.layer.borderColor = UIColor.black.cgColor
        bearView.layer.borderWidth = 2
        bearViewImage.image = UIImage(named: name)
        bearViewLabel.text = text
        targetName = name
    }
    
    // MARK: - メソッド：View（ゆたぽん逃がす画面）を消えさせる
    func dismiss(){
        UIView.animate(withDuration: 0.35, animations: {
            self.alpha = 0
        }) { (bool) in
            self.removeFromSuperview()
        }
    }
    
}

