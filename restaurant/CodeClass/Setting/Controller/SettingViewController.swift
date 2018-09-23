//
//  SettingViewController.swift
//  restaurant
//
//  Created by 劉鉄男 on 2018/9/23.
//  Copyright © 2018年 劉鉄男. All rights reserved.
//

import UIKit
import TimedSilver

class SettingViewController: UIViewController {
    @IBOutlet weak var settingTableView: UITableView!
    
    fileprivate let itemDataSouce: [[(String)]] = [
        [
            (""),
            ],
        [
            ("抽選応募履歴"),
            ("フィードバック"),
            ("利用規約"),
            ("バージョン情報"),
            ],
        ]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor.viewBackgroundColor
//        settingTableView.register(UINib(nibName: "SettingTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingTableViewController")
        
        //settingTableView .register(SettingTableViewCell.classForCoder(), forCellReuseIdentifier: "SettingTableViewCell")
        self.settingTableView.ts_registerCellNib(SettingTableViewCell.self)
        self.settingTableView.ts_registerCellNib(SubSettingTableViewCell.self)
        settingTableView.dataSource = self
        settingTableView.delegate = self
        self.settingTableView.tableFooterView = UIView()

        // Do any additional setup after loading the view.
    }

}

// MARK: @protocol - UITableViewDelegate
extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 15
        } else {
            return 20
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: @protocol - UITableViewDataSource
extension SettingViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.itemDataSouce.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = self.itemDataSouce[section]
        return rows.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 88.0
        } else {
            return 44.0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            //自定义cell
          
            let cell:SettingTableViewCell = tableView.ts_dequeueReusableCell(SettingTableViewCell.self)
            return cell
        } else {
           //自定义cell
          
            let cell:SubSettingTableViewCell = tableView.ts_dequeueReusableCell(SubSettingTableViewCell.self)
            let item = self.itemDataSouce[indexPath.section][indexPath.row]
            cell.titleLabel.text = item
            return cell
        }
    }
}
