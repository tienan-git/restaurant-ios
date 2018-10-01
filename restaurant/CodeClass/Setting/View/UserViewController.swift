//
//  UserViewController.swift
//  restaurant
//
//  Created by パク・セイミ on 2018/09/29.
//  Copyright © 2018年 劉鉄男. All rights reserved.
//

import UIKit
import TimedSilver

class UserViewController: UIViewController {

    @IBOutlet weak var userTableView: UITableView!

    fileprivate var sections = [Section]()
//    fileprivate var headerView: ProfileSettingViewHeaderView?
//    var tmpUser: User = User()
    
    // ================================================================================
    // MARK: tableView struct
    fileprivate enum UserViewTableViewSectionType: Int {
        case userSetting
    }
    
    fileprivate enum UserViewTableViewRowType {
        case nickName
        case profileSettingSaveButton
    }
    
    fileprivate struct Section {
        var sectionType: UserViewTableViewSectionType
        var rowItems: [UserViewTableViewRowType]
    }
    
    fileprivate let itemDataSouce: [[(String)]] = [
        [
            (""),
            ],
        [
            ("名前"),
            ],
        ]
    
//    func footerHeight() -> CGFloat {
//        return 0
//    }
//
//     func registerDataSourceClass() -> AnyClass? {
//        return nil
//    }
    
     func initializeTableViewStruct() {
        sections = [Section(sectionType: .userSetting, rowItems: [.nickName, .profileSettingSaveButton])]
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.userTableView.ts_registerCellNib(UserTableViewCell.self)
        userTableView.dataSource = self
        userTableView.delegate = self
        self.userTableView.tableFooterView = UIView()
        self.initializeTableViewStruct()
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

// MARK: @protocol - UITableViewDelegate
extension UserViewController: UITableViewDelegate {
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
        
        //ここに遷移処理を書く
        switch sections[indexPath.section].rowItems[indexPath.row] {
        case .nickName:
            self.navigationController?.pushViewController(UserViewController(), animated: true)
            break
        case .profileSettingSaveButton:
            self.navigationController?.pushViewController(CyuSenListViewController(), animated: true)
            break
        }
        
    }
}

// MARK: @protocol - UITableViewDataSource
extension UserViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.itemDataSouce.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = self.itemDataSouce[section]
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 200.0
        } else {
            return 44.0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            //自定义cell
            let cell:UserTableViewCell = tableView.ts_dequeueReusableCell(UserTableViewCell.self)
            return cell
        } else {
            //自定义cell
            let cell:UserTableViewCell = tableView.ts_dequeueReusableCell(UserTableViewCell.self)
            let item = self.itemDataSouce[indexPath.section][indexPath.row]
            //cell.titleLabel.text = item
            return cell
        }
    }
    
}

