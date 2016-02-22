//
//  DJLoginVC.swift
//  Duoji
//
//  Created by ZhouQian on 16/2/2.
//  Copyright © 2016年 Angle0047. All rights reserved.
//

import UIKit
import MBProgressHUD

class DJLoginVC: DJLoginBaseVC {
    
    override func viewDidLoad() {
        self.isSignup = false
        self.action = { [weak self] in
            self?.btnLogin.enabled = false;
            DJLoginModel.loginUser((self?.tfAccount.text)!, password: (self?.tfPasswd.text)!, success: { (result: [String : AnyObject]?) -> Void in
                if let result = result {
                    MBProgressHUD.hideHUDForView(self?.view, animated: true)
                    if result["success"] as! Int == 1 {
                        let dict = result["data"] as! [String:AnyObject]
                        DJUser.initWithDictionary(dict)
                        let nav = UINavigationController(rootViewController: DJTweetsVC())
                        self?.presentViewController(nav, animated: true, completion: nil)
                    }
                    else {
                        TOAST_MSG(result["error_msg"] as! String)
                    }
                    
                }
                
                }, failure: { (requestErr: NSError?) -> Void in
                    TOAST_ERROR(requestErr!)
                    self?.btnLogin.enabled = true
                    MBProgressHUD.hideHUDForView(self?.view, animated: true)
            })
        }
        
        super.viewDidLoad()
        
        let signupbtn = UIButton()
        signupbtn.setTitle("注册", forState: UIControlState.Normal)
        signupbtn.titleLabel?.font = DJTheme.kDJFontText
        signupbtn.sizeToFit()
        self.view.addSubview(signupbtn)
        signupbtn.rac_signalForControlEvents(UIControlEvents.TouchUpInside).subscribeNext { [weak self](x: AnyObject!) -> Void in
            self?.presentViewController(DJSignupVC(), animated: true, completion: nil)
        }
        signupbtn.snp_makeConstraints { [weak self](make) -> Void in
            make.trailing.equalTo(self!.view).offset(-kDJSideX)
            make.top.equalTo(self!.view).offset(16)
        }
    }
    
    
}
