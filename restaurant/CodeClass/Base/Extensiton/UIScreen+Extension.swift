//
//  UIScreen+Extension.swift
//  restaurant
//
//  Created by パク・セイミ on 2019/03/12.
//  Copyright © 2019 劉鉄男. All rights reserved.
//

import UIKit

public extension UIScreen {
    
    public class func is3_5inchDisplay() ->Bool{
        return UIScreen.main.bounds.size.height == 480
    }
    
    public class func is4inchDisplay() ->Bool{
        return UIScreen.main.bounds.size.height == 568
    }
    
    public class func is4_7inchDisplay() ->Bool{
        return UIScreen.main.bounds.size.height == 667
    }
    
    public class func is5_5inchDisplay() ->Bool{
        return UIScreen.main.bounds.size.height == 736
    }
    
    public class func isOver4inchDisplay() ->Bool{
        return UIScreen.main.bounds.size.height >= 568
    }
    
    public class func isOver4_7inchDisplay() ->Bool{
        return UIScreen.main.bounds.size.height >= 667
    }
    
    public class func isOver5_8inchDisplay() ->Bool{
        return UIScreen.main.bounds.size.height >= 812
    }
    
    public class func isOver6_1inchDisplay() ->Bool{
        return UIScreen.main.bounds.size.height >= 896
    }
}

