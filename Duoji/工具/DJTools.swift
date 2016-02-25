//
//  DJTools.swift
//  Duoji
//
//  Created by ZhouQian on 16/2/25.
//  Copyright © 2016年 Angle0047. All rights reserved.
//

import UIKit

class DJTools: NSObject {
    class func setLineSpaceOfLabel(label: UILabel) {
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.lineSpacing = kDJLineSpace
        let attrString = NSMutableAttributedString(string: label.text!, attributes: [NSParagraphStyleAttributeName : paraStyle])
        label.attributedText = attrString
    }
    
    class func getLineCountOfText(text: String, font: UIFont, width: CGFloat, lineMode: NSLineBreakMode)->Int {
        let maxSize = CGSize(width: width, height: 999)
        let sizeStandard = "啊".size(maxSize: maxSize, font: font, lineBreakMode: lineMode)
        let size = text.size(maxSize: maxSize, font: font, lineBreakMode: lineMode)
        return Int(size.height / sizeStandard.height)
    }
    
    class func getHeightOfLabel(label: UILabel, width: CGFloat, lineMode: NSLineBreakMode)->CGFloat {
        DJTools.setLineSpaceOfLabel(label)
        let lineCount = DJTools.getLineCountOfText(label.text!, font: label.font, width: width, lineMode: lineMode)
        let sizeStandard = "啊".size(maxSize: CGSize(width: width, height: 999), font: label.font, lineBreakMode: lineMode)
        return ceil(sizeStandard.height) + kDJLineSpace*CGFloat(lineCount)
    }
}
