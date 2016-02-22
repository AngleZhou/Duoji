//
//  DJTheme.swift
//  Duoji
//
//  Created by ZhouQian on 16/1/28.
//  Copyright © 2016年 Angle0047. All rights reserved.
//

import UIKit

class DJTheme {
    
    
    static let kDJFontLogo: UIFont = UIFont.systemFontOfSize(28)
    static let kDJFontMain: UIFont = UIFont.systemFontOfSize(17)
    static let kDJFontText: UIFont = UIFont.systemFontOfSize(15)
    static let kDJFontLittle: UIFont = UIFont.systemFontOfSize(13)
    static let kDJColorMain:UIColor = DJTheme.color(0, green: 128, blue: 255)
    static let kDJColorLine:UIColor = DJTheme.color(200, green: 199, blue: 204)
    static let kDJColorTableViewbg:UIColor = DJTheme.color(239, green: 239, blue: 244)
    
    class func color(red:Int, green:Int ,blue:Int)->UIColor {
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1)
    }
    
    class func setIconFont(btn:UIButton, iconName:String, size: CGFloat) {
        btn.titleLabel?.font = UIFont(name: "IconFont", size: size)!
        btn.setTitle(iconName, forState: UIControlState.Normal)
    }
    class func getIconFont(iconName:String,size: CGFloat)->UILabel {
        let label = UILabel()
        label.font = UIFont(name: "IconFont", size: size)
        label.text = iconName
        return label
    }
    
}


