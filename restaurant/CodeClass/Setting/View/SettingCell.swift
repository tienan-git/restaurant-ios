//
//  SettingCell.swift
//  restaurant
//
//  Created by パク・セイミ on 2019/03/14.
//  Copyright © 2019 劉鉄男. All rights reserved.
//

import SwiftTips

class SettingCell: UITableViewCell, NibProtocol {
    typealias NibT = SettingCell

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
}
