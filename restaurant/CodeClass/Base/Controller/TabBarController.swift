//
//  TabBarController.swift
//  restaurant
//
//  Created by 劉鉄男 on 2018/9/23.
//  Copyright © 2018年 劉鉄男. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    let homeVC = HomeViewController()
    let mapVC = MapViewController()
    let couponVC = CouponViewController()
    let settingVC = SettingViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVC(vc: homeVC, title: "ホーム")
        addChildVC(vc: mapVC, title: "地図")
        addChildVC(vc: couponVC, title: "クーポン")
        addChildVC(vc: settingVC, title: "設定")
    }
    
    // MARK: - メソッド：親Viewに子Viewを追加する
    func addChildVC(vc: UIViewController, title: String) {
        vc.tabBarItem.title = title
        vc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.font : UIFont(name: "Avenir-Medium", size: 14) as Any], for: .normal)
        vc.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -12)
        addChildViewController(vc)
    }


}
