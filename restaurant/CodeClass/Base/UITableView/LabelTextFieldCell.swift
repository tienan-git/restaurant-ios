//
//  LabelTextFieldCell.swift
//  restaurant
//
//  Created by パク・セイミ on 2019/03/14.
//  Copyright © 2019 劉鉄男. All rights reserved.
//

import SwiftTips

class LabelTextFieldCell: UITableViewCell, NibProtocol {
    typealias NibT = LabelTextFieldCell

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textfield: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
}
