//
//  DJBaseTableViewCell.swift
//  Duoji
//
//  Created by tripinsiders on 16/1/9.
//  Copyright © 2016年 Angle0047. All rights reserved.
//

import UIKit
import SnapKit

enum DJTableSeperatorLineStyle {
    case full
    case middle
    case none
}

class DJBaseTableViewCell: UITableViewCell {
    var title: String? {
        didSet {
            lblTitle.text = title
            lblTitle.sizeToFit()
            
            lblTitle.snp_makeConstraints { [weak self] (make) -> Void in
                make.centerY.equalTo(self!)
                make.leading.equalTo(self!).offset(kDJSideX)
                make.trailing.equalTo(self!).offset(-kDJSideX)
            }
        }
    }
    var lineStyle: DJTableSeperatorLineStyle = .none {
        didSet {
            switch lineStyle {
            case .full:
                vline.snp_makeConstraints(closure: { [weak self](make) -> Void in
                    make.leading.equalTo(self!)
                    make.trailing.equalTo(self!)
                    make.bottom.equalTo(self!)
                    make.height.equalTo(0.5)
                })
            case .middle:
                vline.snp_makeConstraints(closure: { [weak self](make) -> Void in
                    make.leading.equalTo(self!).offset(kDJSideX)
                    make.trailing.equalTo(self!).offset(-kDJSideX)
                    make.bottom.equalTo(self!)
                    make.height.equalTo(0.5)
                    })
            case .none:
                break
            }
        }
    }
    var bNext: Bool = false {
        didSet {
            self.accessoryType = bNext ? .DisclosureIndicator : .None
        }
    }
    
    var lblTitle: UILabel
    private var vline: UIView
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        vline = UIView()
        vline.backgroundColor = DJTheme.kDJColorLine
        lblTitle = UILabel()
        lblTitle.font = DJTheme.kDJFontText
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .None
        self.addSubview(lblTitle)
        self.addSubview(vline)
    }
    
    required init?(coder aDecoder: NSCoder) {
        vline = UIView()
        lblTitle = UILabel()
        super.init(coder: aDecoder)
        self.addSubview(lblTitle)
        self.addSubview(vline)
    }

}
