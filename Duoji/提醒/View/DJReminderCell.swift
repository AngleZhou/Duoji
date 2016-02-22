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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        rswitch = UISwitch()

        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.lineStyle = DJTableSeperatorLineStyle.full
        
        rswitch.on = true
        self.addSubview(rswitch)
        rswitch.snp_makeConstraints { [weak self](make) -> Void in
            make.trailing.equalTo(self!).offset(-kDJSideX)
            make.centerY.equalTo(self!)
//            make.size.equalTo(CGSize(width: 50, height: 20))
        }
        
        self.lblTitle.font = DJTheme.kDJFontMain
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
