//
//  LotterDataSource.swift
//  restaurant
//
//  Created by パク・セイミ on 2019/03/12.
//  Copyright © 2019 劉鉄男. All rights reserved.
//

import Foundation
import RealmSwift

@objc public protocol LotteryDataSourceDelegate{
    func completeRequest() ->Void
    func failedRequest(_ error: Error) ->Void
}

class LotteryDataSource {

    weak var delegate: LotteryDataSourceDelegate?
    //応募情報取得
    open func getLottery() {
        Lottery.getLotteryInfo({(lotteryObj, error) in
            self.completeGettingAnyObject(lotteryObj, error: error)
        })
    }
    
    open func completeGettingAnyObject(_ array: Object?, error: Error?) {
        DispatchQueue.main.async(execute: {

            if let error = error {
                self.delegate?.failedRequest(error)
                return
            }

            if array != nil {
                let realm = try! Realm()
                let oldLottery = realm.objects(Lottery.self)
                try! realm.write {
                    realm.delete(oldLottery)
                    realm.add(array!)
                    DBLog(array!)
                }
            }
            
            self.delegate?.completeRequest()
        })
    }
    
}
