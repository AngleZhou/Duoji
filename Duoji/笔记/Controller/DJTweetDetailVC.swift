//
//  DJTweetDetailVC.swift
//  Duoji
//
//  Created by ZhouQian on 16/2/3.
//  Copyright © 2016年 Angle0047. All rights reserved.
//

import UIKit

class DJTweetDetailVC: DJBaseVC {
    
    var textView: UITextView?
    
    var tweet: DJTweet?
    var isNew: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
    }
    func initUI() {
        textView = UITextView(frame: CGRect(x: kDJSideX/2, y: 0, width: kDJScreenWidth - kDJSideX, height: kDJScreenHeight))
        self.view.addSubview(textView!)
        textView!.text = tweet?.content
        textView!.font = DJTheme.kDJFontText
        
        self.actionCustomRightBtnWithNrlImage(nil, htlImage: nil, title: "保存") { [weak self] in
            self?.showLoading()
            if self!.isNew {
                DJTweetsModel.createTweet(self!.textView!.text!, success: { (result) -> Void in
                        print(result)
                    self?.hideLoading()
                    self?.navigationController?.popViewControllerAnimated(true)
                    }, failure: { (requestErr) -> Void in
                        TOAST_ERROR(requestErr!)
                        self?.hideLoading()
                })
            }
            else {
                DJTweetsModel.updateTweet(uuid: self!.tweet!.uuid, content: self!.textView!.text!, success: { (result) -> Void in
                    self!.tweet!.content = self!.textView!.text!
                    self?.hideLoading()
                    self?.navigationController?.popViewControllerAnimated(true)
                    }, failure: { (requestErr) -> Void in
                        TOAST_ERROR(requestErr!)
                        self?.hideLoading()
                })
            }
            
        }
    }
}
