//
//  DJAboutVC.swift
//  Duoji
//
//  Created by ZhouQian on 16/2/6.
//  Copyright © 2016年 Angle0047. All rights reserved.
//

import UIKit

class DJAboutVC: DJBaseVC, UITextViewDelegate {

    var textView: UITextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView = UITextView()
        if let textView = textView {
            textView.dataDetectorTypes = [.Link, .Address]
            textView.font = DJTheme.kDJFontText
            textView.editable = false
            textView.text = "\n多记笔记 http://woaifuxi.com 是一款帮助你学习，复习，积累知识的强大工具。\n\n\"不积跬步无以至千里\"\n子也曾经曰过：\"学而时习之不亦悦乎\"\n。。。。。。\n\n你可以随手记下来任何知识碎片，再设置一个提醒，系统会帮你随机抽出一部分来复习，你也可以自由地复习任何笔记。如果在使用过程中你有任何的需求或者发现任何问题，你可以通过如下方式找到我们：\n\n联系邮箱：waitress@woaifuxi.com"
            self.view.addSubview(textView)
            let size:CGSize = textView.text.size(maxSize: CGSize(width: kDJScreenWidth-2*kDJSideX, height: 999), font: DJTheme.kDJFontText, lineBreakMode: NSLineBreakMode.ByWordWrapping)
            textView.snp_makeConstraints(closure: { [weak self](make) -> Void in
                make.top.equalTo(self!.view)
                make.leading.equalTo(self!.view).offset(kDJSideX)
                make.trailing.equalTo(self!.view).offset(-kDJSideX)
                make.size.equalTo(size)
                })
        }
        
    }

    
}
