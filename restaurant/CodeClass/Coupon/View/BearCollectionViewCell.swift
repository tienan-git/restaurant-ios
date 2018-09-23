//
//  BearCollectionViewCell.swift
//  restaurant
//
//  Created by 劉鉄男 on 2018/9/23.
//  Copyright © 2018年 劉鉄男. All rights reserved.
//

import UIKit

class BearCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var letItGoCellButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 2
    }
    
    // MARK: - メソッド：「逃がす」ボタンに必要情報を追加する
    func configureData(bearName: String, catchTime: String, catchPlace: String, target: Any?, action: Selector, events: UIControlEvents, tag: Int) {
        timeLabel.text = catchTime
        locationLabel.text = catchPlace
        imageView.image = UIImage(named: bearName)
        letItGoCellButton.addTarget(target, action: action, for: events)
        letItGoCellButton.tag = tag
    }
}
