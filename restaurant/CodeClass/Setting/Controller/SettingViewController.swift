//
//  SettingViewController.swift
//  restaurant
//
//  Created by 劉鉄男 on 2018/9/23.
//  Copyright © 2018年 劉鉄男. All rights reserved.
//

import SwiftTips

class SettingViewController: UIViewController {
    
    @IBOutlet weak var settingTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        settingTableView.backgroundColor = kBackGroundColor
        settingTableView.dataSource = self
        settingTableView.delegate = self
        let nibCell = UINib(nibName: SettingCell.nibName, bundle: nil)
        settingTableView.register(nibCell, forCellReuseIdentifier: SettingCell.reuseID)
        let nibHeader = UINib(nibName: SettingSectionHeader.nibName, bundle: nil)
        settingTableView.register(nibHeader, forHeaderFooterViewReuseIdentifier: SettingSectionHeader.reuseID)
    }
    
    fileprivate let numberOfSections: Int = 3
    fileprivate let sectionHeaderTexts: [String] = [
        "ユーザー情報",
        "抽選情報",
        "規約"
    ]
    fileprivate let faqTexts: [[String]] = [
        ["プロフィール"],
        ["抽選履歴","フィードバック"],
        ["利用規約","アプリ情報"]
    ]
    
    fileprivate let faqIcon: [[String]] = [
        ["ic_set_profile"],
        ["ic_set_history","ic_set_history"],
        ["ic_set_terms","ic_set_terms"]
    ]
}

// ================================================================================
// MARK: - UITableViewDataSource

extension SettingViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return self.numberOfSections
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.faqTexts[section].count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.reuseID, for: indexPath) as! SettingCell
        cell.titleLabel.text = self.faqTexts[indexPath.section][indexPath.row]
        cell.iconImage.image = UIImage(named: self.faqIcon[indexPath.section][indexPath.row])
        return cell
    }
}

// ================================================================================
// MARK: - UITableViewDelegate

extension SettingViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SettingSectionHeader.reuseID) as? SettingSectionHeader {
            header.sectionHeaderLabel.text = self.sectionHeaderTexts[section]
            let backgroundView = UIView(frame: header.bounds)
            backgroundView.backgroundColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 0.8)
            header.backgroundView = backgroundView
            return header
        }
        return nil
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var controller: UIViewController
        switch indexPath.section {
        case 0:
            controller = UserViewController()
            break
        case 1:
            if indexPath.row == 0 {
                controller = CyuSenListViewController()
            } else {
                controller = FeedBackViewController()
            }
            break
        case 2:
            if indexPath.row == 0 {
                controller = LegalViewController()
            } else {
                controller = VersionViewController()
            }
            break
        default:
            fatalError("settingPage Section failed")
        }
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
