//
//  DJLoginVC.swift
//  Duoji
//
//  Created by ZhouQian on 16/1/29.
//  Copyright © 2016年 Angle0047. All rights reserved.
//

import UIKit
import ReactiveCocoa
import MBProgressHUD


let minimalUsernameLength = 5
let minimalPasswordLength = 5


class DJLoginBaseVC: DJBaseVC {

    var lblLogo:UILabel
    var tfAccount:UITextField
    var tfPasswd:UITextField
    var btnLogin:UIButton
    var isSignup:Bool = false
    var action: ()->Void
    
    override init() {
        lblLogo = UILabel()
        tfAccount = UITextField()
        tfPasswd = UITextField()
        btnLogin = UIButton()
        action = {}
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        lblLogo = UILabel()
        tfAccount = UITextField()
        tfPasswd = UITextField()
        btnLogin = UIButton()
        action = {}
        super.init(coder: aDecoder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
    }
    
    func initUI() {
        self.view.backgroundColor = DJTheme.kDJColorMain
        self.navigationController?.navigationBar.hidden = true
        
        let logo = UILabel()
        logo.text = self.isSignup ? "创建账户" : "多记笔记"
        logo.textColor = UIColor.whiteColor()
        logo.font = DJTheme.kDJFontLogo
        logo.sizeToFit()
        lblLogo = logo
        self.view.addSubview(lblLogo)
        lblLogo.snp_makeConstraints(closure: { [weak self](make) -> Void in
            make.centerX.equalTo(self!.view)
            make.top.equalTo(self!.view).offset(77)
            })
        
        
        let account = UITextField()
        account.placeholder = "邮箱"
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 44))
        leftView.backgroundColor = UIColor.whiteColor()
        account.leftView = leftView
        account.leftViewMode = .Always
        account.backgroundColor = UIColor.whiteColor()
        tfAccount = account
        self.view.addSubview(tfAccount)
        tfAccount.snp_makeConstraints(closure: { [weak self](make) -> Void in
            make.leading.equalTo(self!.view)//.offset(kDJSideX)
            make.trailing.equalTo(self!.view)//.offset(-kDJSideX)
            make.centerX.equalTo(self!.view)
            make.top.equalTo(self!.lblLogo.snp_bottom).offset(36)
            make.height.equalTo(44)
        })
        
        
        let line = UIView()
        line.backgroundColor = DJTheme.kDJColorLine
        self.view.addSubview(line)
        line.snp_makeConstraints { [weak self](make) -> Void in
            make.top.equalTo(self!.tfAccount.snp_bottom)
            make.leading.equalTo(self!.tfAccount)
            make.trailing.equalTo(self!.tfAccount)
            make.height.equalTo(0.5)
        }
        
        let passwd = UITextField()
        passwd.placeholder = "密码"
        let pleftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 44))
        pleftView.backgroundColor = UIColor.whiteColor()
        passwd.leftView = pleftView
        passwd.leftViewMode = .Always
        passwd.backgroundColor = UIColor.whiteColor()
        passwd.secureTextEntry = true;
        tfPasswd = passwd
        self.view.addSubview(tfPasswd)
        tfPasswd.snp_makeConstraints(closure: { [weak self](make) -> Void in
            make.leading.equalTo(self!.tfAccount)
            make.trailing.equalTo(self!.tfAccount)
            make.centerX.equalTo(self!.view)
            make.top.equalTo(line.snp_bottom)
            make.height.equalTo(44)
        })
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.width - kDJSideX*2, height: kDJButtonHeight))
        let title = self.isSignup ? "注册" : "登录"
        button.setTitle(title, forState: UIControlState.Normal)
        button.backgroundColor = DJTheme.color(0, green: 69, blue: 208)
        btnLogin = button
        self.view.addSubview(btnLogin)
        btnLogin.rac_signalForControlEvents(UIControlEvents.TouchUpInside).subscribeNext { [weak self](x: AnyObject!) -> Void in
            MBProgressHUD.showHUDAddedTo(self?.view, animated: true)
            self?.action()
            if self!.tfAccount.isFirstResponder() {
                self!.tfAccount.resignFirstResponder()
            }
            if self!.tfPasswd.isFirstResponder() {
                self!.tfPasswd.resignFirstResponder()
            }
            
        }
        
        RACSignal.combineLatest([self.tfAccount.rac_textSignal(), self.tfPasswd.rac_textSignal()]) { [weak self]() -> AnyObject! in
            return self?.tfAccount.text?.characters.count > 0 && self?.tfPasswd.text?.characters.count > 0
            }.subscribeNext { [weak self](valid: AnyObject!) -> Void in
                let btnvalid = valid as! Bool
                self?.btnLogin.enabled = btnvalid
                self?.btnLogin.alpha = btnvalid ? 1 : 0.5
        }

        
        
        button.snp_makeConstraints { [weak self](make) -> Void in
            make.leading.equalTo(self!.view).offset(kDJSideX)
            make.trailing.equalTo(self!.view).offset(-kDJSideX)
            make.top.equalTo(self!.tfPasswd.snp_bottom).offset(20)
        }
        
        
        
    }

}
