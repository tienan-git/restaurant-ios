//
//  LotterDataSource.swift
//  restaurant
//
//  Created by パク・セイミ on 2019/03/12.
//  Copyright © 2019 劉鉄男. All rights reserved.
//

import Foundation
import RealmSwift

class LotteryDataSource: BaseDataSource {

    //応募情報取得
    open func updateLotteryByRefresh(_ shouldRefresh: Bool) {
        getLottery(shouldRefresh: shouldRefresh)
    }

    private func getLottery(shouldRefresh: Bool) {
        Lottery.getLotteryInfo({ [weak self] (lotteryObj, error) in
            if let lottery = lotteryObj {
                let realm = try! Realm()
                let oldLottery = realm.objects(Lottery.self)
                try! realm.write {
                    realm.delete(oldLottery)
                    realm.add(lottery)
                }
            }
        })
    }
    
}
