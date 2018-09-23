//
//  FooterReusableView.swift
//  restaurant
//
//  Created by 劉鉄男 on 2018/9/23.
//  Copyright © 2018年 劉鉄男. All rights reserved.
//

import UIKit
import RealmSwift

class FooterReusableView: UICollectionReusableView{
    
    @IBOutlet weak var LetAllGoButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - メソッド：「全て逃がす」ボタンに必要情報を追加する
    func configureData(target: Any?, action: Selector, events: UIControlEvents){
        LetAllGoButton.addTarget(target, action: action, for: events)
    }
}
