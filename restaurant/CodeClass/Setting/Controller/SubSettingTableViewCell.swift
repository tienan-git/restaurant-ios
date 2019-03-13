//
//  SubSettingTableViewCell.swift
//  restaurant
//
//  Created by パク・セイミ on 2018/09/23.
//  Copyright © 2018年 劉鉄男. All rights reserved.
//

import SwiftTips

class SubSettingTableViewCell: UITableViewCell, NibProtocol {
    typealias NibT = SubSettingTableViewCell

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
