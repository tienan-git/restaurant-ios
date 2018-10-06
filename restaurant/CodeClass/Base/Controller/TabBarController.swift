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
//    let couponVC = CouponViewController()
    let settingVC = SettingViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVC(vc: homeVC, title: "抽選")
        addChildVC(vc: mapVC, title: "地図")
//        addChildVC(vc: couponVC, title: "クーポン")
        addChildVC(vc: settingVC, title: "設定")
    }
    
    override func viewDidLayoutSubviews() {
        let numberOfItems = CGFloat(self.childViewControllers.count)
        let tabBarItemSize = CGSize(width: tabBar.frame.width / numberOfItems, height: tabBar.frame.height)
        tabBar.selectionIndicatorImage = imageWithColor(color: UIColor.blue, size: tabBarItemSize).resizableImage(withCapInsets: UIEdgeInsets.zero)
        tabBar.tintColor = UIColor.white
        tabBar.isTranslucent = false
        tabBar.frame.size.width = self.view.frame.width + 4
        tabBar.frame.origin.x = -2
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - メソッド：選択されているTabに背景色を追加する
    func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    // MARK: - メソッド：親Viewに子Viewを追加する
    func addChildVC(vc: UIViewController, title: String) {
        vc.tabBarItem.title = title
        vc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.font : UIFont(name: "Avenir-Medium", size: 14) as Any], for: .normal)
        vc.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -12)
        addChildViewController(vc)
    }
    
}
