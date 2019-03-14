//
//  ButtonCell.swift
//  restaurant
//
//  Created by パク・セイミ on 2019/03/14.
//  Copyright © 2019 劉鉄男. All rights reserved.
//

import SwiftTips

class ButtonCell: UITableViewCell, NibProtocol {
    typealias NibT = ButtonCell
    
    @IBOutlet weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = kBackGroundColor
        self.selectionStyle = .none
    }

}
