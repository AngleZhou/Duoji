//
//  DJTweetCell.swift
//  Duoji
//
//  Created by tripinsiders on 16/1/8.
//  Copyright © 2016年 Angle0047. All rights reserved.
//

import UIKit

let sideX: CGFloat = 10
let sideY: CGFloat = 6
let sideTitleX: CGFloat = 8
let sideTitleY: CGFloat = 11

class DJTweetCell: UITableViewCell {
    var title: String? {
        didSet {
            if let title = title {
                lbltitle?.text = title
                
                let size = title.size(maxSize: CGSize(width: kDJScreenWidth-sideX*2-sideTitleX*2, height: 999), font: lbltitle!.font, lineBreakMode: NSLineBreakMode.ByWordWrapping)
                lbltitle?.height = size.height
                bgView?.height = lbltitle!.height + sideTitleY*2
                self.height = lbltitle!.height + sideTitleY*2 + sideY*2
            }
            
        }
    }
    var bgView: UIView?
    var lbltitle: UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = DJTheme.color(239, green: 239, blue: 244)
        self.selectionStyle = .None
        
        bgView = UIView(frame: CGRect(x: sideX, y: sideY, width: kDJScreenWidth - sideX * 2, height: self.contentView.height - sideY * 2))
        bgView!.backgroundColor = UIColor.whiteColor()
        bgView!.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        bgView!.layer.shadowRadius = 1.0
        bgView!.layer.shadowOpacity = 0.5
        self.addSubview(bgView!)
        
        lbltitle = UILabel(frame: CGRect(x: sideTitleX+sideX, y: sideTitleY+sideY, width: kDJScreenWidth - sideTitleX * 2 - sideX * 2, height: self.contentView.height - sideTitleY * 2))
        lbltitle!.font = DJTheme.kDJFontText
        lbltitle!.textColor = UIColor.blackColor()
        lbltitle!.textAlignment = .Left
        lbltitle!.lineBreakMode = .ByWordWrapping
        lbltitle!.numberOfLines = 0
        lbltitle!.backgroundColor = UIColor.whiteColor()
        self.addSubview(lbltitle!)
        
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}