//
//  DJTweetDetailVC.swift
//  Duoji
//
//  Created by ZhouQian on 16/2/3.
//  Copyright © 2016年 Angle0047. All rights reserved.
//

import UIKit

protocol DJTweetReturnDelegate {
    func DJTweetReturn(tweet: DJTweet);
}


class DJTweetDetailVC: DJBaseVC {
    
    var textView: UITextView?
    
    var tweet: DJTweet?
    var isNew: Bool = false
    var delegate: DJTweetReturnDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
    }
    func initUI() {
        textView = UITextView(frame: CGRect(x: kDJSideX/2, y: 0, width: kDJScreenWidth - kDJSideX, height: kDJScreenHeight))
        self.view.addSubview(textView!)
        textView!.text = tweet?.content
        textView!.font = DJTheme.kDJFontText
        
        let btnSave = self.addbtnSave()
        let btnDelete = self.addbtnDelete()
        let rightBtns = self.isNew ? [btnSave] : [btnSave, btnDelete]
        self.navigationItem.rightBarButtonItems = rightBtns
    }
    
    func addbtnSave()->UIBarButtonItem {
        return UIBarButtonItem(title: "保存", style: UIBarButtonItemStyle.Plain, target: self, action: "saveTweet")
    }
    func saveTweet() {
        self.showLoading()
        if self.isNew {
            DJTweetsModel.createTweet(self.textView!.text!, success: { [weak self](result: [String : AnyObject]?) -> Void in
                print(result)
                self?.hideLoading()
                if let result = result {
                    let data = result["data"] as! NSDictionary
                    let tweet = DJTweet.init(dictionary: data as [NSObject : AnyObject])
                    self?.delegate?.DJTweetReturn(tweet)
                    self?.navigationController?.popViewControllerAnimated(true)
                }
                
                }, failure: { [weak self](requestErr) -> Void in
                    TOAST_ERROR(requestErr!)
                    self?.hideLoading()
            })
        }
        else {
            DJTweetsModel.updateTweet(uuid: self.tweet!.uuid, content: self.textView!.text!, success: { [weak self](result) -> Void in
                self!.tweet!.content = self!.textView!.text!
                self?.hideLoading()
                self?.navigationController?.popViewControllerAnimated(true)
                }, failure: {[weak self] (requestErr) -> Void in
                    TOAST_ERROR(requestErr!)
                    self?.hideLoading()
            })
        }
    }
    func addbtnDelete()->UIBarButtonItem {
        return UIBarButtonItem(title: "删除", style: UIBarButtonItemStyle.Plain, target: self, action: "deleteTweet")
    }
    func deleteTweet() {
        self.showLoading()
        DJTweetsModel.deleteTweet(tweet: self.tweet!, success: { [weak self](result) -> Void in
            let model = DJBaseModel(dictionary: result)
            if model.success == 1 {
                self?.hideLoading()
                self?.navigationController?.popViewControllerAnimated(true)
            }
            else {
                TOAST_MSG(model.error_msg!)
                self?.hideLoading()
            }
            
            
            }) { [weak self](requestErr) -> Void in
                TOAST_ERROR(requestErr!)
                self?.hideLoading()
        }
    }
}
