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
        let results = realm.objects(LotteryHistory.self)
        return results.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let results = realm.objects(LotteryHistory.self)
        // セルを取得する
        let cell = tableView.dequeueReusableCell(withIdentifier: "CyusenListViewController", for: indexPath) as! CyusenListViewCell
        
        if indexPath.item == 0 {
            cell.CyusenDateLabel.text = "抽選日時"
           // cell.CyusenItemLabel.text = "抽選アイテム"
            cell.CyusenResultLabel.text = "抽選結果"
            return cell
        }else{
            cell.CyusenDateLabel.text = results[indexPath.item-1].applyDateTime
           // cell.CyusenItemLabel.text = results[indexPath.item-1].lotteryTitle
            cell.CyusenResultLabel.text = results[indexPath.item-1].lotteryStatus
            return cell
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        getLotteryHistory()
    }
    
    // 最新施設情報取得
    func getLotteryHistory() {
        
        LotteryService.shared.getLotteryHistories(
            url: apiGetLotteriesHistories,
            succeed: { (lotteryHistories) in
                self.addLotteryHistories(newLotteryHistories: lotteryHistories)
                self.cyusenTableView.reloadData()
                
        },
            failed: { (message) in
                dPrint("取得していなかったが、何もしないつもり")
                }
        )
    }
    
    // 施設情報洗替
    func addLotteryHistories(newLotteryHistories: [LotteryHistory]) {
        
        let realm = try! Realm()
        let oldLotteryHistories = realm.objects(LotteryHistory.self)
        try! realm.write {
            realm.delete(oldLotteryHistories)
            for lotteryHistory in newLotteryHistories {
                realm.add(lotteryHistory)
            }
        }
    }
    
}
