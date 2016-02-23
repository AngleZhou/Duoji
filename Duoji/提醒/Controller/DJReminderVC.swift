//
//  DJReminderVC.swift
//  Duoji
//
//  Created by ZhouQian on 16/2/6.
//  Copyright © 2016年 Angle0047. All rights reserved.
//

import UIKit

class DJReminderVC: DJBaseTableVC {

    var reminderModel: DJReminderModel = DJReminderModel.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        
    }

    func initUI() {
        self.navigationItem.title = "提醒"
        self.tableView.backgroundColor = DJTheme.kDJColorTableViewbg
        self.actionCustomRightBtnWithNrlImage("\u{e600}", htlImage: nil, title: nil) { [weak self]() -> Void in
            let newReminder = DJReminderDetail()
            newReminder.isNew = true
            let nav = UINavigationController(rootViewController: newReminder)
            self?.presentViewController(nav, animated: true, completion: nil)
        }
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reminderModel.reminders.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = "REMINDERCELL"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? DJReminderCell
        if cell == nil {
            cell = DJReminderCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
        }
        
        if let cell = cell {
            let reminder:DJReminder = reminderModel.reminders[indexPath.row] as! DJReminder
            cell.reminder = reminder
        }
        
        return cell!
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detail = DJReminderDetail()
        let reminder:DJReminder = reminderModel.reminders[indexPath.row] as! DJReminder
        detail.date = reminder.fireDate
        detail.isNew = false
        self.navigationController?.pushViewController(detail, animated: true)
    }

}
