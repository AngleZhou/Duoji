//
//  DJNetWorkApi.swift
//  Duoji
//
//  Created by tripinsiders on 16/1/2.
//  Copyright © 2016年 Angle0047. All rights reserved.
//

import Foundation
import Alamofire


typealias DJNetworkSuccessBlock = (result: [String : AnyObject]?)->Void
typealias DJNetworkFailureBlock = (requestErr: NSError?)->Void


class DJNetWorkApi: NSObject {
    static let sharedInstance = DJNetWorkApi()
    
    func requestWithoutAuth(url url: String, parasDict:[String : AnyObject]?, success: DJNetworkSuccessBlock, failure: DJNetworkFailureBlock) {
        var requestURL: String
        
        if !url.containsString("http") {
            requestURL = String(format: "%@%@", DJUrls.api, url)
        }
        else {
            requestURL = url
        }
        self.request(requestURL, parasDict: parasDict, success: success, failure: failure)
    }
    
    func requestWithURL(url: String, parasDict:[String : AnyObject]?, success: DJNetworkSuccessBlock, failure: DJNetworkFailureBlock) {
        
        var requestURL: String
        if !url.containsString("http") {
            requestURL = String(format: "%@%@", DJUrls.api, url)
        }
        else {
            requestURL = url
        }
        requestURL = String(format: "%@auth_token=%@", requestURL, DJUser.authToken()!)
        self.request(requestURL, parasDict: parasDict, success: success, failure: failure)
   
    }
    
    func request(requestURL: String, parasDict:[String : AnyObject]?, success: DJNetworkSuccessBlock, failure: DJNetworkFailureBlock) {
        var httpRequest : Request?
        if var para = parasDict {
            if para["isCreate"] != nil {
                para["isCreate"] = nil
                httpRequest = Alamofire.request(.POST, requestURL, parameters: para, encoding: .JSON, headers: nil)
            }
            else if para["isUpdate"] != nil {
                para["isUpdate"] = nil
                httpRequest = Alamofire.request(.PATCH, requestURL, parameters: para, encoding: .JSON, headers: nil)
            }
            else if para["isDelete"] != nil {
                httpRequest = Alamofire.request(.DELETE, requestURL)
            }
            else if para["isGet"] != nil {
                httpRequest = Alamofire.request(.GET, requestURL)
            }
            else {
                print("network request para error!")
            }
            
            httpRequest?.responseJSON(completionHandler: { Response in
                if Response.result.isSuccess {
                    let dic = Response.result.value as! [String : AnyObject]
                    success(result: dic)
                }
                else {
                    failure(requestErr: Response.result.error)
                }
            })
            
        }
        else {
            print("request para cannot be nil")
        }
    }
}
