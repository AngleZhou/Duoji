//
//  DJReminderDetail.swift
//  Duoji
//
//  Created by ZhouQian on 16/2/20.
//  Copyright © 2016年 Angle0047. All rights reserved.
//

import UIKit

class DJReminderDetail: DJBaseVC {
    var isNew: Bool = false
    var date: NSDate?
    private var datePicker: UIDatePicker = UIDatePicker()
    private var btnDelete: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
    }
    func initUI() {
        self.navigationItem.title = self.isNew ? "新建提醒" : "修改提醒"
        self.view.backgroundColor = DJTheme.kDJColorTableViewbg
        self.actionCustomLeftBtnWithNrlImage(nil, htlImage: nil, title: "取消") { [weak self]() -> Void in
            self?.dismissViewControllerAnimated(true, completion: nil)
        }
        self.actionCustomRightBtnWithNrlImage(nil, htlImage: nil, title: "保存") { [weak self]() -> Void in
            //save
        }
        
        self.datePicker.datePickerMode = .Time
        self.datePicker.date = (date != nil ? date! : NSDate())
        self.view.addSubview(self.datePicker)
        self.datePicker.snp_makeConstraints { [weak self](make) -> Void in
            make.leading.equalTo(self!.view)
            make.trailing.equalTo(self!.view)
            make.top.equalTo(self!.view).offset(100)
        }
        
        self.btnDelete.setTitle("删除闹钟", forState: UIControlState.Normal)
        self.btnDelete.setTitleColor(DJTheme.kDJColorMain, forState: UIControlState.Normal)
        self.btnDelete.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.btnDelete)
        self.btnDelete.snp_makeConstraints { [weak self](make) -> Void in
            make.leading.equalTo(self!.view)
            make.trailing.equalTo(self!.view)
            make.top.equalTo(self!.datePicker.snp_bottom).offset(20)
        }
        self.btnDelete.rac_signalForControlEvents(UIControlEvents.TouchUpInside).takeUntil(self.rac_willDeallocSignal()).subscribeNext { [weak self](AnyObject) -> Void in
            if self!.isNew {
                self?.dismissViewControllerAnimated(true, completion: nil)
            }
            else {
                DJReminderModel().deleteReminderAtDate(self!.date!)
                self?.navigationController?.popViewControllerAnimated(true)
            }
        }
    }
}
