//
//  DJReminderCell.swift
//  Duoji
//
//  Created by ZhouQian on 16/2/15.
//  Copyright © 2016年 Angle0047. All rights reserved.
//

import UIKit

class DJReminderCell: DJBaseTableViewCell {
    var rswitch:UISwitch
    var reminder:DJReminder {
        didSet {
            self.title = NSDate.descriptionTime(reminder.fireDate)
            rswitch.on = self.reminder.on ? true : false
            rswitch.on ? self.normalStyle() : self.disabledStyle()
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        rswitch = UISwitch()
        reminder = DJReminder(hour: 0, minute: 0)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.lineStyle = DJTableSeperatorLineStyle.full
        
        self.addSubview(rswitch)
        rswitch.snp_makeConstraints { [weak self](make) -> Void in
            make.trailing.equalTo(self!).offset(-kDJSideX)
            make.centerY.equalTo(self!)
        }
        
        rswitch.rac_signalForControlEvents(UIControlEvents.ValueChanged).takeUntil(self.rac_willDeallocSignal()).subscribeNext { [weak self](AnyObject) -> Void in
            if self!.rswitch.on {
                self?.normalStyle()
                DJReminder.scheduleNotificationAtDate(self!.reminder.fireDate)
                self?.reminder.on = true
                DJReminderModel.sharedInstance.save()
            }
            else {
                self?.disabledStyle()
                DJReminder.cancelNotificationAtDate(self!.reminder.fireDate)
                self?.reminder.on = false
                DJReminderModel.sharedInstance.save()
            }
            
        }
        
        self.lblTitle.font = DJTheme.kDJFontMain
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func normalStyle() {
        self.lblTitle.enabled = true
        self.backgroundColor = UIColor.whiteColor()
    }
    
    func disabledStyle() {
        self.lblTitle.enabled = false
        self.backgroundColor = DJTheme.kDJColorTableViewbg
    }
}




