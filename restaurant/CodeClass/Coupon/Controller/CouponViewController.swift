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

class CouponViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, BearReleaseViewDelegate {
    
    @IBOutlet weak var bearCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    
    // MARK: - イベント：「逃がす」ボタンをタップする時
    @objc func onClickMyButton(_ sender: UIButton) {
        let BearReleaseView = Bundle.main.loadNibNamed("BearReleaseView", owner: nil, options: nil)?.first as! BearReleaseView
        BearReleaseView.delegate = self
        BearReleaseView.makeMyWindow(name: results[sender.tag].bearImageName, text: results[sender.tag].bearImageName + "を\n逃しますか？")
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
    
    // MARK: - メソッド：「全て逃がす」「ゆたぽんを捕まえてください」の表示制御
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionElementKindSectionFooter) {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CartFooterCollectionReusableView", for: indexPath) as! FooterReusableView
            footerView.configureData(target: self, action: #selector(onClickLetAllGoButton(_:)), events: .touchUpInside)
            
            if results.count == 0 { // buttonFlag == true ||
                footerView.LetAllGoButton.setTitle("ゆたぽんを捕まえてください", for: .normal)
                footerView.LetAllGoButton.isEnabled = false
                footerView.LetAllGoButton.setTitleColor(UIColor.gray, for: .normal)
                footerView.LetAllGoButton.backgroundColor = UIColor.white
            } else {
                footerView.LetAllGoButton.setTitle("全て逃がす", for: .normal)
                footerView.LetAllGoButton.isEnabled = true
                footerView.LetAllGoButton.setTitleColor(UIColor.white, for: .normal)
                footerView.LetAllGoButton.backgroundColor = Color_letAllGoBGColor
            }
            
            return footerView
        }
        
        if (kind == UICollectionElementKindSectionHeader) {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CartHeaderCollectionReusableView", for: indexPath)
            return headerView
        }
        
        fatalError()
    }
    
}
