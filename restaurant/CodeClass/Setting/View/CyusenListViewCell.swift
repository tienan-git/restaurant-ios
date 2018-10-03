//
//  CyusenListViewCell.swift
//  restaurant
//
//  Created by パク・セイミ on 2018/10/02.
//  Copyright © 2018年 劉鉄男. All rights reserved.
//

import UIKit

class CyusenListViewCell: UITableViewCell {

    @IBOutlet weak var CyusenDateLabel: UILabel!
    @IBOutlet weak var CyusenItemLabel: UILabel!
    @IBOutlet weak var CyusenResultLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
