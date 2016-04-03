//
//  DJBaseModel.swift
//  Duoji
//
//  Created by ZhouQian on 16/1/29.
//  Copyright © 2016年 Angle0047. All rights reserved.
//

import UIKit
import JSONModel
import jastor

class DJBaseModel: Jastor {
    var success: Int = 0
    var error_msg: String?
    
//    override class func propertyIsOptional(propertyName: String!) -> Bool {
//        return true
//    }
//    
//    override class func keyMapper() -> JSONKeyMapper {
//        return JSONKeyMapper.mapperFromUnderscoreCaseToCamelCase();
//    }
}
