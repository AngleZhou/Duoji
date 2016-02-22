//
//  DJUrls.swift
//  Duoji
//
//  Created by tripinsiders on 16/1/2.
//  Copyright © 2016年 Angle0047. All rights reserved.
//

import Foundation

struct DJUrls {
    static let host = "http://woaifuxi.com"
    static let api = String(format: "%@/%@", host, "api/")
    static let user = String(format: "%@/%@", api, "users")
    
    static let signUp = "signup"
    static let login = "login"
//    static let authToken = String(format: "%@/%@", "auth_token=", DJUser.authToken())
    
    
    static let tweet = String(format: "%@tweets?", api)
    static func tweet(id id: Int)->String {
        return String(format: "%@tweets/%d?", api,id)
    }
};