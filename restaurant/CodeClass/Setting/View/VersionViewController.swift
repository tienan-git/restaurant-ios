//
//  VersionViewController.swift
//  restaurant
//
//  Created by パク・セイミ on 2018/09/29.
//  Copyright © 2018年 劉鉄男. All rights reserved.
//

import UIKit

class VersionViewController: UIViewController {

    @IBOutlet weak var version: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let versionno: String! = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        
        version.text="バージョン "+versionno
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
