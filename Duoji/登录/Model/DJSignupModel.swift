//
//  DJSignupModel.swift
//  Duoji
//
//  Created by tripinsiders on 16/1/2.
//  Copyright © 2016年 Angle0047. All rights reserved.
//

import Foundation

class DJSignupModel: NSObject {
    static func signupUser(username: String, passwd: String, success: DJNetworkSuccessBlock, failure: DJNetworkFailureBlock) {
        let dicParam:[String : AnyObject] = ["email": username, "password": passwd, "password_confirmation": passwd, "isCreate":true]
        DJNetWorkApi.sharedInstance.requestWithoutAuth(url: DJUrls.signUp, parasDict: dicParam, success: success, failure: failure)
    }
}
