//
//  User.swift
//  restaurant
//
//  Created by パク・セイミ on 2019/03/14.
//  Copyright © 2019 劉鉄男. All rights reserved.
//

open class User: BaseModelObject {
    var identifier: String? ///id
    var nickName: String? ///名前
    var gender: Int? ///性別
    var comment: String? ///自己紹介
    var createdAt: Date? ///アカウント作成日時
    var updatedAt: Date?///アカウント更新日時
//    var email: Email? = Email() ///emailの情報
//    var phone: Phone? = Phone() ///phoneの情報
//    var password: Password? = Password() ///passwordの情報
    var photo: Photo? = Photo() ///profile iconの情報
//    var facebook: Facebook? = Facebook() /// facebookの情報
}
