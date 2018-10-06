//
//  CyuSenListViewController.swift
//  restaurant
//
//  Created by パク・セイミ on 2018/09/23.
//  Copyright © 2018年 劉鉄男. All rights reserved.
//

import UIKit
import RealmSwift

class CyuSenListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var cyusenTableView: UITableView!
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cyusenTableView.register(UINib(nibName: "CyusenListViewCell", bundle: nil), forCellReuseIdentifier: "CyusenListViewController")
        cyusenTableView.dataSource = self
        cyusenTableView.delegate = self
        
        title = "抽選履歴"
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let results = realm.objects(Cyusen.self)
        return results.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let results = realm.objects(Cyusen.self)
        // セルを取得する
        let cell = tableView.dequeueReusableCell(withIdentifier: "CyusenListViewController", for: indexPath) as! CyusenListViewCell
        
        if indexPath.section == 0 {
            cell.CyusenDateLabel.text = "抽選日時"
            cell.CyusenItemLabel.text = "抽選アイテム"
            cell.CyusenResultLabel.text = "抽選結果"
            return cell
        }else{
            cell.CyusenDateLabel.text = results[indexPath.item].applyDateTime
            cell.CyusenItemLabel.text = results[indexPath.item].lotteryTitle
            cell.CyusenResultLabel.text = results[indexPath.item].lotteryStatus
            return cell
        }
      
        
    }
   
}
