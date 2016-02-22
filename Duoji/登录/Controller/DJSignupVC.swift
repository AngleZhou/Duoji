//
//  DJSignupVC.swift
//  Duoji
//
//  Created by ZhouQian on 16/2/1.
//  Copyright © 2016年 Angle0047. All rights reserved.
//

import UIKit
import MBProgressHUD

class DJSignupVC: DJLoginBaseVC {
    
    override func viewDidLoad() {
        self.isSignup = true
        self.action = { [weak self] in
            self?.btnLogin.enabled = false
            DJSignupModel.signupUser((self?.tfAccount.text)!, passwd: (self?.tfPasswd.text)!, success: { (result) -> Void in
                if let result = result {
                    MBProgressHUD.hideHUDForView(self?.view, animated: true)
                    if result["success"] as! Int == 1 {
                        DJUser.initWithDictionary(result)
                        let nav = UINavigationController(rootViewController: DJTweetsVC())
                        self?.presentViewController(nav, animated: true, completion: nil)
                    }
                    else {
                        TOAST_MSG(result["error_msg"] as! String)
                    }
                }
                
                }, failure: { (requestErr) -> Void in
                    TOAST_ERROR(requestErr!)
                    self?.btnLogin.enabled = true
                    MBProgressHUD.hideHUDForView(self?.view, animated: true)
            })
        }
        super.viewDidLoad()

        let cancel = UIButton()
        cancel.setTitle("取消", forState: UIControlState.Normal)
        cancel.titleLabel?.font = DJTheme.kDJFontText
        cancel.sizeToFit()
        self.view.addSubview(cancel)
        cancel.rac_signalForControlEvents(UIControlEvents.TouchUpInside).subscribeNext { [weak self](x: AnyObject!) -> Void in
            self?.dismissViewControllerAnimated(true, completion: nil)
        }
        cancel.snp_makeConstraints { [weak self](make) -> Void in
            make.leading.equalTo(self!.view).offset(kDJSideX)
            make.top.equalTo(self!.view).offset(16)
        }
    }


    

}
