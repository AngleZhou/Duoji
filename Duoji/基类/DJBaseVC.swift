//
//  DJBaseVC.swift
//  Duoji
//
//  Created by tripinsiders on 16/1/9.
//  Copyright © 2016年 Angle0047. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD


class DJBaseVC: UIViewController {
    private struct AssociatedKeys {
        static var DescriptiveName = "btnClickAction"
    }
    
    var navLeftButton: UIButton?
    var navRightButton: UIButton?
    
    
    typealias ButtonAction = ()->Void
    
    init() {
        navLeftButton = UIButton(type: UIButtonType.Custom)
        navRightButton = UIButton(type: UIButtonType.Custom)
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        
//        print("%@",)
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.whiteColor()
    }
    func actionBack(btnClickAction: ()->Void) {
        self.actionCustomLeftBtnWithNrlImage(nil, htlImage: nil, title: "Back", action: btnClickAction)
    }
    
    func actionCustomLeftBtnWithNrlImage(nrlImage: String?, htlImage: String?, title: String?, action:(()->Void)?) {
        self.navLeftButton!.backgroundColor = UIColor.clearColor()
        let block = {//()->Void in
            let reachability: Reachability
            do {
                reachability = try Reachability.reachabilityForInternetConnection()
            } catch {
                print("Unable to create Reachability")
                return
            }
            reachability.whenUnreachable = { reachability in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    __notify(kNotifyBadNetwork)
                })
            }
            
            if action != nil {
                action!()
            }
        }
        
        let blockObj = ObjectWrapper(value: block)
        objc_setAssociatedObject(self.navLeftButton, &AssociatedKeys.DescriptiveName, blockObj as AnyObject, .OBJC_ASSOCIATION_COPY)
        self.actionCustomNavBtn(self.navLeftButton!, nrlImage: nrlImage, htlImage: htlImage, title: title)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: self.navLeftButton!)
    }
    
    func actionCustomRightBtnWithNrlImage(nrlImage: String?, htlImage: String?, title: String?, action:(()->Void)?) {
        if let action = action {
            let action = ObjectWrapper(value: action)
            objc_setAssociatedObject(self.navRightButton, &AssociatedKeys.DescriptiveName, action as AnyObject, .OBJC_ASSOCIATION_COPY)
        }
        
        self.actionCustomNavBtn(self.navRightButton!, nrlImage: nrlImage, htlImage: htlImage, title: title)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.navRightButton!)
    }
    
    func actionCustomNavBtn(button: UIButton, nrlImage: String?, htlImage: String?, title: String?) {
        if let htlImage = htlImage {
            DJTheme.setIconFont(button, iconName: htlImage, size: 24)
            button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        } else if let nrlImage = nrlImage {
            DJTheme.setIconFont(button, iconName: nrlImage, size: 24)
            button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        }
        
        if let title = title {
            button.setTitle(title, forState: .Normal)
            button.setTitle(title, forState: .Highlighted)
        }
        button.sizeToFit()
        button.addTarget(self, action: "actionBtnClick:", forControlEvents: .TouchUpInside)
        
    }
    
    func actionBtnClick(button: UIButton) {
        let actionObj = objc_getAssociatedObject(button, &AssociatedKeys.DescriptiveName) as? ObjectWrapper<ButtonAction>
        if let actionObj = actionObj {
            actionObj.value()
        }
    }
    
    func showLoading() {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
    }
    func hideLoading() {
        MBProgressHUD.hideHUDForView(self.view, animated: true)
    }
}
