//
//  DJLoginModel.swift
//  Duoji
//
//  Created by tripinsiders on 16/1/2.
//  Copyright © 2016年 Angle0047. All rights reserved.
//

import Foundation


class DJLoginModel: NSObject {
        
    static func loginUser(userName: String, password: String, success: DJNetworkSuccessBlock, failure: DJNetworkFailureBlock) {
        let dicParam:[String : AnyObject] = ["email": userName, "password":password, "isCreate":true]
        DJNetWorkApi.sharedInstance.requestWithoutAuth(url: DJUrls.login, parasDict: dicParam, success: success, failure: failure)
    }
}
