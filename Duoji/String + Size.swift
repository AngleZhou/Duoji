//
//  String + Size.swift
//  Duoji
//
//  Created by ZhouQian on 16/2/3.
//  Copyright © 2016年 Angle0047. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func size(maxSize maxSize: CGSize, font: UIFont, lineBreakMode: NSLineBreakMode) -> CGSize {
        let txt: NSString = self as NSString
        let style: NSMutableParagraphStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle;
        style.lineBreakMode = lineBreakMode
        let attributes = [NSFontAttributeName : font, NSParagraphStyleAttributeName : style]
        let rect = txt.boundingRectWithSize(maxSize, options: [NSStringDrawingOptions.UsesLineFragmentOrigin, NSStringDrawingOptions.UsesFontLeading], attributes: attributes, context: nil)
        
        return CGSize(width: ceil(rect.size.width), height: ceil(rect.size.height))
    }
}
