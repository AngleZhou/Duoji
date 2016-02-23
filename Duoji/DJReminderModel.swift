//
//  DJReminderModel.swift
//  Duoji
//
//  Created by ZhouQian on 16/2/15.
//  Copyright © 2016年 Angle0047. All rights reserved.
//

import Foundation
import UIKit


class DJReminderModel: DJBaseModel {
    var reminders = NSMutableArray()
    static let sharedInstance = DJReminderModel()
    
    private override init() {
        super.init()
        let data = self.loadFromLocal()
        if data == nil {
            reminders.addObject(DJReminder(hour: 7, minute: 30))
            reminders.addObject(DJReminder(hour: 12, minute: 0))
            reminders.addObject(DJReminder(hour: 21, minute: 0))
        }
        else {
            reminders = data!
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadFromLocal()->NSMutableArray? {
        let path = NSBundle.mainBundle().pathForResource("Reminders", ofType: "plist")
        if path == nil {
            return nil
        }
        let dict = NSArray(contentsOfURL: NSURL(fileURLWithPath: path!))
        if let dict = dict {
            let rems = NSMutableArray()
            for r in dict {
                let reminder = DJReminder(dictionary: r as! [NSObject : AnyObject])
                rems.addObject(reminder)
            }
            return rems
        }
        return nil
    }
    func save() {
        let documentPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first
        let path = documentPath!.stringByAppendingString("/Reminders.plist")
        let newArr = NSMutableArray()
        for r in self.reminders {
            let reminder = r as! DJReminder
            let reDict = reminder.toDictionary()
            newArr.addObject(reDict)
        }
        newArr.writeToFile(path, atomically: true)
    }
    
    
    func saveReminderAtDate(date:NSDate) {
        self.reminders.addObject(DJReminder(date: date))
        self.save()
    }
    
    func deleteReminderAtDate(date:NSDate) {
        let re = self.reminderOfDate(date)
        if let re = re {
            DJReminder.cancelNotificationAtDate(re.fireDate)
            self.reminders.removeObjectIdenticalTo(re)
        }
        self.save()
    }
    func changeReminderFromDate(date:NSDate, toDate:NSDate) {
        let re = self.reminderOfDate(date)
        if let _ = re {
            self.deleteReminderAtDate(date)
            self.reminders.addObject(DJReminder(date: toDate))
        }
    }
    
    func reminderOfDate(date:NSDate)->DJReminder? {
        let remindercopy:NSArray = self.reminders
        let predicate = NSPredicate(format: "SELF.fireDate == %@", date)
        let filteredArr = remindercopy.filteredArrayUsingPredicate(predicate)
        if filteredArr.count > 0 {
            let re = filteredArr.first as! DJReminder
            return re
        }
        return nil
    }
    
}