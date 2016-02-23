//
//  DJReminder.swift
//  Duoji
//
//  Created by ZhouQian on 16/2/20.
//  Copyright © 2016年 Angle0047. All rights reserved.
//

import Foundation
import UIKit

class DJReminder:DJBaseModel {
    var on:Bool = true
    var fireDate:NSDate
    init(date: NSDate) {
        fireDate = date
        super.init()
        DJReminder.scheduleNotificationAtDate(date)
    }
    override init!(dictionary: [NSObject : AnyObject]!) {
        on = dictionary["on"] as! Bool
        fireDate = dictionary["time"] as! NSDate
        super.init(dictionary: dictionary)
        DJReminder.scheduleNotificationAtDate(fireDate)
    }
    init(hour: Int, minute: Int) {
        let comp = NSDateComponents()
        comp.hour = hour
        comp.minute = minute
        comp.second = 0
        let date = (NSCalendar.currentCalendar().dateFromComponents(comp))!
        fireDate = date
        super.init()
        DJReminder.scheduleNotificationAtDate(date)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func scheduleNotificationAtDate(date: NSDate) {
        let alert = UILocalNotification()
        alert.alertBody = "该复习了哦"
        alert.fireDate = date;
        alert.soundName = UILocalNotificationDefaultSoundName
        alert.repeatInterval = NSCalendarUnit.Day
        
        if UIApplication.instancesRespondToSelector("registerUserNotificationSettings:") {
            UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [UIUserNotificationType.Alert, UIUserNotificationType.Badge, UIUserNotificationType.Sound], categories: nil))
            UIApplication.sharedApplication().scheduleLocalNotification(alert)
        }
    }
    
    class func cancelNotificationAtDate(date:NSDate) {
        let notes = UIApplication.sharedApplication().scheduledLocalNotifications
        if notes != nil && notes?.count > 0 {
            for note in notes! {
                let tInterval = note.fireDate?.timeIntervalSinceDate(date)
                let tIntervalInt = Int64(tInterval!)
                if tIntervalInt % (24*60*60) == 0 {
                    UIApplication.sharedApplication().cancelLocalNotification(note)
                }
            }
        }
    }
    
    
    
}