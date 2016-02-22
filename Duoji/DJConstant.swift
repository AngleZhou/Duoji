//
//  DJConstant.swift
//  Duoji
//
//  Created by tripinsiders on 16/1/9.
//  Copyright © 2016年 Angle0047. All rights reserved.
//

import Foundation
import UIKit
import JLToast


let kDJSideX: CGFloat         = 18
let kDJScreenWidth            = UIScreen.mainScreen().bounds.size.width
let kDJScreenHeight           = UIScreen.mainScreen().bounds.size.height
let kDJTableViewSpace:CGFloat = 10
let kDJButtonHeight: CGFloat  = 44

let kNotifyBadNetwork = "kNotifyBadNetwork"
func __notify(noteName:String) {NSNotificationCenter.defaultCenter().postNotificationName(noteName, object: nil)}
func __observe(observer:AnyObject, selector:Selector, noteName:String) {NSNotificationCenter.defaultCenter().addObserver(observer, selector: selector, name: noteName, object: nil)}
func __removeNotifiObserver(observer:AnyObject) {NSNotificationCenter.defaultCenter().removeObserver(observer)}




func TOAST_ERROR(error: NSError) {
    JLToastView.setDefaultValue(kDJScreenHeight/2, forAttributeName: JLToastViewPortraitOffsetYAttributeName, userInterfaceIdiom: .Phone)
    JLToast.makeText(error.localizedDescription, duration: 2.0).show()
    print("%@", error.localizedDescription)
}

func TOAST_MSG(msg: String) {
    JLToastView.setDefaultValue(kDJScreenHeight/2, forAttributeName: JLToastViewPortraitOffsetYAttributeName, userInterfaceIdiom: .Phone)
    JLToast.makeText(msg, duration: 2.0).show()
    print("%@", msg)
}


