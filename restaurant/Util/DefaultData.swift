//
//  DefaultData.swift
//  restaurant
//
//  Created by 劉鉄男 on 2018/9/23.
//  Copyright © 2018年 劉鉄男. All rights reserved.
//

import UIKit

// MARK: - スクリーンサイズ
let kScreenWidth = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height

// MARK: - 常用色
let Color_F5F5F5 = UIColor.colorWithHexCode(code: "F5F5F5")
let Color_333 = UIColor.colorWithHexCode(code: "333333")
let Color_666 = UIColor.colorWithHexCode(code: "666666")
let Color_999 = UIColor.colorWithHexCode(code: "999999")
let Color_ccc = UIColor.colorWithHexCode(code: "cccccc")
let Color_letAllGoBGColor = UIColor.colorWithHexCode(code: "F77C72")

// MARK: - Realmバッジョん
let currentRealmVersion: UInt64 = 1

// MARK: - リクエストページサイズ
let requestPageSize = 20

// MARK: - 施設情報取得URL
let getSpotsProdUrl = "http://ar-setting.touchandpay-japan.com.s3-website-ap-northeast-1.amazonaws.com/" // 本番URL
let getSpotsTestUrl = "http://spots.arapp.opentone.pandamall.jp.s3-website-ap-northeast-1.amazonaws.com" // テストURL

// MARK: - ゆたぽん情報同期URL
let postYutaponsProdUrl = "http://ar-mng.touchandpay-japan.com/synchronization" // 本番URL
let postYutaponsTestUrl = "http://backoffice.arapp.opentone.pandamall.jp.s3-website-ap-northeast-1.amazonaws.com" // テストURL

// MARK: - 施設利用可能サービス名前配列
let spotServiceNameArray = ["チケット発行", "チケット利用", "LIQUID Pay 支払", "LIQUID マネーチャージ", "LIQUID ポイントチャージ", "パスポート込ユーザー登録", "既存ユーザーへの指紋登録", "ユーザー照会"]

// MARK: - ゆたぽん現れる頻度（間隔時間：何秒）
let bearAppearIntervalTime: Int = 120

// MARK: - ゆたぽん現れる時間（持続時間：何秒）
let bearAppearDurationTime: Int = 30

// MARK: - ゆたぽんが同時に現れる最大件数
let bearAppearMaxCount:Int = 1

// MARK: - イベント特別施設用ゆたぽんのイメージネーム配列
let eventSpecialBearImageNameArray = ["ゆたぽん（レッド）", "ゆたぽん（ピンク）"]

// MARK: - イベント非特別施設用ゆたぽんのイメージネーム配列
let eventUnspecialBearImageNameArray = ["ゆたぽん（イエロー）", "ゆたぽん（グリーン）", "ゆたぽん（ブルー）"]

// MARK: - 通常施設ゆたぽんのイメージネーム配列
let bearImageNameArray = ["ゆたぽん（レッド）", "ゆたぽん（ピンク）", "ゆたぽん（イエロー）", "ゆたぽん（グリーン）", "ゆたぽん（ブルー）"]
