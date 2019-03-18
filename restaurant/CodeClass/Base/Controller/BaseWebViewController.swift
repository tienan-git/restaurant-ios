//
//  BaseWebViewController.swift
//  restaurant
//
//  Created by パク・セイミ on 2019/03/18.
//  Copyright © 2019 劉鉄男. All rights reserved.
//

import UIKit

class BaseWebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var url: URL?
    
    deinit {
        url = nil
        DBLog("-----------------BaseWebViewController Deinit -------------------")
    }
    
    required public init(url: URL) {
        super.init(nibName: nil, bundle: nil)
        self.url = url
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myURLRequest:URLRequest = URLRequest(url: self.url!)
        webView.loadRequest(myURLRequest)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
