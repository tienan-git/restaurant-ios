//
//  ToolViewController.swift
//  restaurant
//
//  Created by パク・セイミ on 2019/03/18.
//  Copyright © 2019 劉鉄男. All rights reserved.
//

import UIKit

class ToolViewController: UIViewController {
    
    @IBAction func goToWebView(_ sender: UIButton) {
        let url: URL = URL(string: "http://www.baidu.com")!
        let controller = BaseWebViewController(url: url)
        controller.title = "BaseWebView"
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
