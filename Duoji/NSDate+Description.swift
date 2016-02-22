//
//  NSDate+Description.swift
//  Duoji
//
//  Created by ZhouQian on 16/2/20.
//  Copyright © 2016年 Angle0047. All rights reserved.
//

import Foundation

extension NSDate {
    class func descriptionTime(date: NSDate)-> String {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .NoStyle
        formatter.timeStyle = .ShortStyle
        return formatter.stringFromDate(date)
    }
}
