//
//  NSAttributedString+Extension.swift
//  restaurant
//
//  Created by パク・セイミ on 2019/03/12.
//  Copyright © 2019 劉鉄男. All rights reserved.
//

import UIKit

public extension NSAttributedString {
    
    public func getTextHeight(_ viewWidth:CGFloat) ->CGFloat{
        let paragraphRect: CGRect = self.boundingRect(with: CGSize(width: viewWidth, height: CGFloat.greatestFiniteMagnitude),
            options: [.usesLineFragmentOrigin,.usesFontLeading],
            context: nil)
        
        return ceil(paragraphRect.size.height)
    }
    
    public func getTextWidth(_ viewHeight:CGFloat) ->CGFloat{
        let paragraphRect: CGRect = self.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: viewHeight),
            options: [.usesLineFragmentOrigin,.usesFontLeading],
            context: nil)
        
        return ceil(paragraphRect.size.width)
    }
    
}
