//
//  CommentCell.swift
//  restaurant
//
//  Created by パク・セイミ on 2019/03/14.
//  Copyright © 2019 劉鉄男. All rights reserved.
//

import SwiftTips

class CommentCell: UITableViewCell, NibProtocol {
    typealias NibT = CommentCell

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var wordCountLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
 
}
