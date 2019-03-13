//
//  UIViewController+Extension.swift
//  restaurant
//
//  Created by パク・セイミ on 2019/03/12.
//  Copyright © 2019 劉鉄男. All rights reserved.
//
import UIKit

extension UIViewController {
    var currentTopViewController: UIViewController? {
        if let viewController = self as? UINavigationController {
            return viewController.topViewController?.currentTopViewController
        }
        if let viewController = self as? UITabBarController {
            return viewController.selectedViewController?.currentTopViewController
        }
        if let viewController = self.presentedViewController {
            return viewController.currentTopViewController
        }
        return self
    }
}
