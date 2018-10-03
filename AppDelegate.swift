//
//  AppDelegate.swift
//  restaurant
//
//  Created by 劉鉄男 on 2018/9/23.
//  Copyright © 2018年 劉鉄男. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var locationManager: CLLocationManager!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        debugPrint(NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true))
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let tabbar = TabBarController()
        let nav = UINavigationController(rootViewController: tabbar)
        
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        // 位置情報使用権限確認
        if CLLocationManager.locationServicesEnabled() && !(CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse) {
            locationManager = CLLocationManager()
            locationManager.requestWhenInUseAuthorization()
        }
        
        // realmオブジェクト定義変更時の自動migration
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        let _ = try! Realm(configuration: config)
        
        // 最新施設情報取得
        getSpots()
        return true
    }
    
    func setAWhenApplicationin(_ str: String) {
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        
        // 最新施設情報取得
        getSpots()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

extension AppDelegate {
    
    // 最新施設情報取得
    func getSpots() {
        // 本番URLでAPIを呼び出し
        CommonService.shared.getSpots(url: getSpotsProdUrl,
                                      succeed: { (spots) in
                                        self.addSpots(newSpots: spots)
        },
                                      failed: { (message) in
                                        // テストURLでAPIを呼び出し（本番URLで失敗する場合）
                                        CommonService.shared.getSpots(url: getSpotsTestUrl,
                                                                      succeed: { (spots) in
                                                                        self.addSpots(newSpots: spots)
                                        },
                                                                      failed: { (message) in
                                                                        let realm = try! Realm()
                                                                        if realm.objects(Restaurant.self).isEmpty { // 最新施設情報取得失敗時にローカル施設情報が無い場合、下記アラートを画面に表示させる
                                                                            UtilClass.alertViewShowWithoutCancel(vc: UtilClass.AppCurrentViewController() ?? UIViewController(), title: message, sureHandler: nil)
                                                                        }
                                        }
                                        )
        }
        )
    }
    
    // 施設情報洗替
    func addSpots(newSpots: [Restaurant]) {
        
        let realm = try! Realm()
        let oldSpots = realm.objects(Restaurant.self)
        try! realm.write {
            realm.delete(oldSpots)
            for spot in newSpots {
                // 施設情報に不備がある場合、取り込み対象外とする
//                if spot.spotId != "" {
//                    realm.add(spot)
//                }
            }
        }
    }
    
    // ゆたぽん情報同期
    func postYutapons() {
        
        // 端末ID取得
        let deviceId = UIDevice.current.identifierForVendor!.uuidString
        
        // ゆたぽん情報取得
        let realm = try! Realm()
        let bearObjs = realm.objects(Coupon.self)
        var bearDics: [[String:Any]] = []
        if bearObjs.count > 0 {
            for bearObj: Coupon in bearObjs {
                let bearDic: [String:Any] = bearObj.convertIntoDictionary()
                bearDics.append(bearDic)
            }
        }
        let yutaponDic: [String:Any] = [
            "deviceId": deviceId,
            "data": bearDics
        ]
        
        // 本番URLでAPIを呼び出し
        CommonService.shared.postYutapons(url: postYutaponsProdUrl, yutaponDic: yutaponDic,
                                          succeed: { (message) in
                                            dPrint(message)
        },
                                          failed: { (message) in
                                            dPrint(message)
                                            
                                            // テストURLでAPIを呼び出し（本番URLで失敗する場合）
                                            CommonService.shared.postYutapons(url: postYutaponsTestUrl, yutaponDic: yutaponDic,
                                                                              succeed: { (message) in
                                                                                dPrint(message)
                                            },
                                                                              failed: { (message) in
                                                                                dPrint(message)
                                            }
                                            )
        }
        )
    }
}
