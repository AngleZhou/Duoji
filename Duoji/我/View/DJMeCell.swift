//
//  DJMeCell.swift
//  Duoji
//
//  Created by ZhouQian on 16/2/4.
//  Copyright © 2016年 Angle0047. All rights reserved.
//

import UIKit

class DJMeCell: DJBaseTableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        lblTitle.font = DJTheme.kDJFontText
        self.lineStyle = DJTableSeperatorLineStyle.full
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }

}
