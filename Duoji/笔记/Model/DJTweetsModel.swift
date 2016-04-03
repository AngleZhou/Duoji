//
//  DJTweetsModel.swift
//  Duoji
//
//  Created by tripinsiders on 16/1/9.
//  Copyright © 2016年 Angle0047. All rights reserved.
//

import Foundation
import JSONModel



class DJTweet: DJBaseModel {
    var content: String?
    var id: Int?
    var uuid: String = ""
    var updated_at: String = ""
    var created_at: String = ""
    var hint: String?
    var deleted: Bool?
    var user_id: Int?
}

class DJTweetsModel: DJBaseModel {
    static let sharedInstance = DJTweetsModel()
    var data:[DJTweet]?
    
//    override class func protocolForArrayProperty(propertyName: String!) -> String! {
//        DJTweet.self
//        return "DJTweet"
//    }
    class func data_class() ->AnyClass {
        return DJTweet.self
    }
    
    
    class func getTweets(success: DJNetworkSuccessBlock, failure: DJNetworkFailureBlock) {
        DJNetWorkApi.sharedInstance.requestWithURL(DJUrls.tweet, parasDict: ["isGet":true], success: success, failure: failure)
    }

    class func deleteTweet(tweet tweet: DJTweet, success: DJNetworkSuccessBlock, failure: DJNetworkFailureBlock) {
        self.sharedInstance.data!.removeObject(tweet)

        DJNetWorkApi.sharedInstance.requestWithURL(DJUrls.tweet(uuid: tweet.uuid), parasDict:["isDelete":true], success: success, failure: failure)
    }
    class func updateTweet(uuid uuid: String, content: String, success: DJNetworkSuccessBlock, failure: DJNetworkFailureBlock) {
        let dic = ["isUpdate":true, "content": content] as [String : AnyObject]
        DJNetWorkApi.sharedInstance.requestWithURL(DJUrls.tweet(uuid: uuid), parasDict: dic, success: success, failure: failure)
    }
    class func createTweet(content: String, success: DJNetworkSuccessBlock, failure: DJNetworkFailureBlock) {
        let dic = ["isCreate":true, "content": content] as [String : AnyObject]
        DJNetWorkApi.sharedInstance.requestWithURL(DJUrls.tweet, parasDict: dic, success: success, failure: failure)
    }
}
