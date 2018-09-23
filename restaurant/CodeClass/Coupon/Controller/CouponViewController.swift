//
//  CouponViewController.swift
//  restaurant
//
//  Created by 劉鉄男 on 2018/9/23.
//  Copyright © 2018年 劉鉄男. All rights reserved.
//

import UIKit
import RealmSwift

let realm = try! Realm()
let results = realm.objects(Bear.self).filter("status == '0'")

class CouponViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, BearReleaseViewDelegate, SpotViewDelegate {
    func routeGuideOrOnlyForClose() {
        
    }
    
    
    @IBOutlet weak var bearCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBear()
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize.init(width: (kScreenWidth - 70) / 2, height:280)
        layout.sectionInset = UIEdgeInsets(top: 20, left: 25, bottom: 0, right: 25)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        layout.footerReferenceSize = CGSize(
            width: kScreenWidth, height: 50)
        bearCollectionView.collectionViewLayout = layout
        bearCollectionView.register(UINib.init(nibName: "BearCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BearCollectionViewCell")
        bearCollectionView.register(UINib.init(nibName: "FooterReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "CartFooterCollectionReusableView")
        bearCollectionView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addBear()
    }
    
    
    // MARK: - イベント：「逃がす」ボタンをタップする時
    @objc func onClickMyButton(_ sender: UIButton) {
        let spotView = Bundle.main.loadNibNamed("SpotView", owner: nil, options: nil)?.first as! SpotView
        spotView.spotRouteGuideButton.setTitle("使用する", for: UIControlState.normal)
        spotView.makeMyWindow(spotName: "", spotType: "", spotServiceArray: [], spotImageUrl: "")
        spotView.delegate = self as? SpotViewDelegate
    }
    
    // MARK: - イベント：「全て逃がす」ボタンをタップする時
    @objc func onClickLetAllGoButton(_ sender: UIButton) {
        let BearReleaseView = Bundle.main.loadNibNamed("BearReleaseView", owner: nil, options: nil)?.first as! BearReleaseView
        BearReleaseView.delegate = self
        BearReleaseView.makeMyWindow(name: "ゆたぽん（ファイブ）", text: "全てのゆたぽんを\n逃しますか？")
    }
    
    // MARK: - メソッド：図鑑表示内容をreloadする
    func passOnInformation(letAllGoButtonFlag: Bool) {
        bearCollectionView.reloadData()
    }
    
    // MARK: - メソッド：図鑑に表示させるゆたぽん（cell）件数をカウントする
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    // MARK: - メソッド：ゆたぽん（cell）を図鑑に表示させる
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BearCollectionViewCell", for: indexPath) as! BearCollectionViewCell
        cell.configureData(bearName: results[indexPath.row].bearImageName, catchTime: results[indexPath.row].catchTime, catchPlace: results[indexPath.row].catchPlace, target: self, action: #selector(onClickMyButton(_:)), events: .touchUpInside, tag: indexPath.row)
        return cell
    }
    
    func useCoupon() {
        dPrint("クーポン使用")
    }
    
    func addBear(){
        let realm = try! Realm()
        let newBear = Bear(bearImageName: "ゆたぽん（レッド）", catchTime: Date.currentDateStringWithoutTimeZoneString, catchPlace: "秋葉原", status: "0")
        try! realm.write {
            realm.add(newBear)
        }
    }
    
}
