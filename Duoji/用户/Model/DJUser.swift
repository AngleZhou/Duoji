//
//  CJUser.swift
//  Duoji
//
//  Created by tripinsiders on 16/1/1.
//  Copyright © 2016年 Angle0047. All rights reserved.
//

import Foundation


class DJUserItem: NSObject {
    var email: String? {
        didSet {
            NSUserDefaults.standardUserDefaults().setValue(self.email, forKey: "email")
        }
    }
    var authToken: String? {
        didSet {
            NSUserDefaults.standardUserDefaults().setValue(self.authToken, forKey: "authToken")
        }
    }
    var id: Int? {
        didSet {
            NSUserDefaults.standardUserDefaults().setValue(self.id, forKey: "id")
        }
    }
    var avatar: String? {
        didSet {
            NSUserDefaults.standardUserDefaults().setValue(self.avatar, forKey: "avatar")
        }
    }
    var username: String? {
        didSet {
            NSUserDefaults.standardUserDefaults().setValue(self.username, forKey: "username")
        }
    }
    
    override init() {
        let defaults = NSUserDefaults.standardUserDefaults()
        email = defaults.stringForKey("email")
        authToken = defaults.stringForKey("authToken")
        id = defaults.integerForKey("id")
        avatar = defaults.stringForKey("avatar")
        username = defaults.stringForKey("username")
    }
}



class DJUser: NSObject {
    var data: DJUserItem
    
    static let sharedUser = DJUser();
    
    private override init() {
        data = DJUserItem()
        super.init()
    }

    class func initWithDictionary(dict: [String : AnyObject]) {
        if let email = dict["email"] {
            DJUser.sharedUser.data.email = email as? String
        }
        if let authToken = dict["auth_token"] {
            DJUser.sharedUser.data.authToken = authToken as? String
        }
        if let id = dict["id"] {
            DJUser.sharedUser.data.id = id as? Int
        }
        if let avatar = dict["avatar"] {
            DJUser.sharedUser.data.avatar = avatar as? String
        }
        if let name = dict["username"] {
            DJUser.sharedUser.data.avatar = name as? String
        }
    }
    
    class func clearUserInfo() {
        DJUser.sharedUser.data.email = ""
        DJUser.sharedUser.data.authToken = ""
        DJUser.sharedUser.data.id = 0
        DJUser.sharedUser.data.avatar = ""
        DJUser.sharedUser.data.username = ""
        
        
    }
    
    class func authToken()->String? {
        return DJUser.sharedUser.data.authToken
    }
    class func name()->String {
        let data = DJUser.sharedUser.data
        if data.username == nil {
            return data.email!
        }
        return data.username!
    }
    
    func synchronize() {
        
    }
    
}
